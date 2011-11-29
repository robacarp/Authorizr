
module Authorizr
  module Model
    module ClassMethods
      # Attempts to find the controller class for this model using railsy style
      # Override this method if you use nonstandard controller names...
      def controller
        guess = ActiveSupport::Inflector.pluralize(self.name) + 'Controller'
        begin
          troller = Object.const_get guess
        rescue NameError
          nil
        end
      end

      def authorize params={}
        params[:user] ||= nil
        params[:resource] ||= nil
        params[:action] ||= nil

        troller = self.controller
        if troller.respond_to? :manually_authorize
          troller.manually_authorize params
        else
          raise NoMethodError, "#{troller.name} does not respond to :manually_authorize"
        end
      end

      def permissable
        self.class_eval do
          include Authorizr::Model::Permissable
        end #block
      end #def permissable

    end #ClassMethods

    #methods included in models which declare themselves to be permissable
    module Permissable
      def can? action, object
        if object.respond_to?(:authorize)
          object.authorize :user => self, :resource => nil, :action => action
        elsif object.class.respond_to?(:authorize)
          object.class.authorize :user => self, :resource => object, :action => action
        else
          false
        end
      end
    end

    def self.included to
      to.extend ClassMethods
    end

  end
end

ActiveRecord::Base.send :include, Authorizr::Model
