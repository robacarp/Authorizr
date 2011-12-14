require "rails"

module Authorizr
  module Rails
    class Railtie < ::Rails::Railtie

      ActiveSupport.on_load :action_controller do
        require 'Authorizr/controller'
      end

      ActiveSupport.on_load :active_record do
        require 'Authorizr/model'
      end

    end
  end
end
