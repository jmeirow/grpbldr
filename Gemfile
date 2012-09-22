source 'http://rubygems.org'

gem 'rails', '3.2.8'
gem 'actionmailer', '3.2.8'
gem 'pg', '0.14.0'
gem 'eventmachine'
gem 'kaminari'
gem 'tzinfo'
gem 'chronic'
gem 'ori'
gem 'hirb'
gem 'bcrypt-ruby', :require => "bcrypt"
gem 'railsthemes'
gem 'execjs'
gem "sidekiq", "~> 2.1.0"
gem 'sinatra', :require => nil
gem 'jquery-rails'
gem 'capistrano'
gem 'mail'
gem 'flt'
gem 'mailman', :require => false
gem 'slim'



group :development do
  gem 'thin' 
  gem 'letter_opener'  
  gem 'pry' 
  gem 'pry-doc' 
  gem 'pry-rails' 
  gem 'pry_debug'  
  gem 'pry-nav' 
  gem 'pry-stack_explorer'
end

group :test do
  gem 'faker'
  gem 'capybara'
  gem 'database_cleaner', '~> 0.7.2'
  gem 'launchy'
  gem 'turn', '0.8.2', :require => false
end

group :development, :test do
  gem 'slim'
  gem 'rspec-rails' 
  gem 'rb-inotify' 
  gem 'factory_girl_rails'
  gem 'letter_opener'  
  gem 'guard-rspec'
end

group :production do
  gem 'turn', '0.8.2', :require => false
  gem 'unicorn'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.5'
  gem 'coffee-rails', '~> 3.2.2'
  gem 'uglifier', '>= 1.0.3'
end






