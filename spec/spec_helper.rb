require 'bundler/setup'

require 'rspec'
require 'capybara/rspec'
require 'site_prism.vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures'
end