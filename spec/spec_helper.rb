require 'bundler/setup'

require 'rspec'
require 'capybara/rspec'
require 'site_prism.vcr'
require 'support/pages/main'

require_relative '../app'

Capybara.default_driver = :selenium
Capybara.app = GithubApp

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :faraday
  c.ignore_localhost = true
end