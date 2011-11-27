
module Auth
  module Controller
    module ClassMethods
      def authorize_all
        before_filter :authorize!
      end

      #a hook for other object to authorize from outside the request object
      def authorize user, resource, action
        auth_block = @@authorization_blocks[self.to_s]
        authorized = unless auth_block.nil?
                       auth_block.call({
                         :user => user,
                         :resource => resource,
                         :action => action,
                         :params => {},
                         :model => resource.class
                       })
                     else
                       false
                     end
      end

      #these methods will be called from the Class level, not the instance level
      def auth &block
        @@authorization_blocks[self.to_s] = block unless block.nil?
      end

      def unauthorized &block
        @@failure_blocks[self.to_s] = block unless block.nil?
      end

      #build maintain a catalog of the auth/unauth blocks provided by the child controllers
      def create_authblock_catalog
        @@authorization_blocks = {}
        @@failure_blocks = {}
      end

      mattr_reader :authorization_blocks
      mattr_reader :failure_blocks
    end

    def self.included to
      to.extend ClassMethods
      to.create_authblock_catalog
    end


    #the before-filter that gets called on every action
    def authorize!
      authorized = call_auth_block

      logit authorized
      return true if authorized
      call_failure_block
    end

    def call_auth_block
      auth_block = self.class.authorization_blocks[self.class.to_s]
      return false if auth_block.nil?

      params ||= nil

      model, resource = build_resource params

      auth_block.call({
        :user => current_user,
        :action => self.action_name,
        :controller => self,
        :params => params,
        :resource => resource,
        :model => model
      })
    end

    def call_failure_block
      failure_block = self.class.failure_blocks[self.class.to_s]

      if failure_block.nil?
        render_error and return false
      else
        abort_action = failure_block.call({:controller => self})

        if !abort_action
          # if a render has been declared by the abort action, don't call the default error render error
          render_error unless performed?
          return false
        else
          abort_action
        end
      end
    end

    def logit authorized
      if Rails.env == 'development'
        if authorized
          Rails.logger.warn "\033[32mGRANT:\033[0m #{self.controller_name} #{self.action_name}" 
        else
          Rails.logger.warn "\033[31mDENY:\033[0m #{self.controller_name} #{self.action_name}" 
        end
      end
    end

    #override in application
    def current_user
      nil
    end

    #attempt to sort out a model from the url and controller name
    def build_resource parameters
      return [nil, nil] if parameters.nil? || parameters[:id].nil?
      model_name = self.controller_name.classify

      begin
        model = Module.const_get model_name
        if model.respond_to? :find
          resource = model.find parameters[:id]
        else
          model = nil
        end
      rescue ActiveRecord::RecordNotFound, NameError
        model = resource = nil
      end

      [model, resource]
    end

    def render_error
      render :text => '404'
    end
  end
end

ActionController::Base.send :include, Auth::Controller
