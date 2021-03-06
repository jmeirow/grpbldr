require File.expand_path('../boot', __FILE__)
require "sprockets/railtie"

require 'rails/all' 

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups(:assets => %w(development test production)))
  # If you want your assets lazily compiled in production, use this line
  #Bundler.require(:default, :assets, Rails.env)
end

module Rolemaster
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    config.active_record.observers = :absence_observer, :admin_observer, :agenda_bottom_observer, :agenda_definition_observer, :agenda_line_item_observer, :agenda_top_observer, :agreement_observer, :assignment_observer, :assignment_report_observer, :available_assignment_observer, :club_observer, :contest_signup_observer, :email_observer, :leader_history_observer, :leader_observer, :meeting_note_observer, :meeting_observer, :meeting_type_observer, :member_notification_preference_observer, :member_observer, :notification_type_observer, :role_group_association_observer, :role_group_observer, :role_meeting_type_observer, :role_observer, :sys_configuration_observer, :update_observer, :user_observer
    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Eastern Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Enable the asset pipeline
    config.assets.enabled = true

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.12'
    
    config.active_record.whitelist_attributes = true

    config.active_record.default_timezone = :local


 


    
    
  end
end
