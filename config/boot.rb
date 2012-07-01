require 'rubygems'

# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

# ::Rails.root.to_s = "#{File.dirname(__FILE__)}/.." unless defined?( ::Rails.root.to_s)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])
