require "authorizr"
require "rails"

module Authorizr
  class Engine < Rails::Engine
    engine_name :auth
  end
end
