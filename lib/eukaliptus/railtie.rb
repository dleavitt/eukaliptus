require 'eukaliptus/middleware'
require 'rails'
require 'view_helpers/facebook_helper'

module Facebook
end

module Eukaliptus
  class Railtie < Rails::Railtie
    # Load rake tasks
    rake_tasks do
      load File.join(File.dirname(__FILE__), '../tasks/facebook.rake')
    end
    
    initializer "eukaliptus.initializer", :after => :after_initialize do |app|
      #ActionView::Base.send :include, Helper
      app.middleware.use Eukaliptus::Middleware

      CONFIG = YAML.load_file(Rails.root.join("config/facebook.yml"))[Rails.env]
      Facebook::APP_ID = CONFIG['app_id']
      Facebook::SECRET = CONFIG['secret_key']
      Facebook::CANVAS = CONFIG['canvas']
    end
  end
end