require "rails"

module Authorizr
  module Rails
    class Railtie < ::Rails::Railtie

      ActiveSupport.on_load :action_controller do
        require 'authorizr/controller'
      end

      ActiveSupport.on_load :active_record do
        require 'authorizr/model'
      end

    end
  end
end
