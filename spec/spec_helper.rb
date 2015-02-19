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
  c.preserve_exact_body_bytes { false }

  c.default_cassette_options = {
    serialize_with:         :psych,
    allow_playback_repeats: true
  }
end