require 'bundler/setup'

require 'rspec'
require 'capybara/rspec'
require 'site_prism.vcr'

require 'support/pages/main'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures'
end