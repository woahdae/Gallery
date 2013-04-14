ENV['RAILS_ENV'] = 'test'
require File.expand_path('../../config/environment', __FILE__)

require 'minitest/autorun'
require 'minitest/rails'
require 'minitest/spec'

Dir.glob(Rails.root + 'test/support/*.rb').each {|f| require f}

Turn.config do |c|
  c.format = :outline
  c.natural = true
end

VCR.configure do |c|
  c.cassette_library_dir = 'test/cassettes'
  c.hook_into :webmock
  c.allow_http_connections_when_no_cassette = true
end

# comment/uncomment while deciding on whether or not to use
# in-memory sqlite3 (see also database.yml; need this for ':memory:')
ActiveRecord::Schema.verbose = false
require Rails.root + 'db/schema.rb'

class MiniTest::Spec
  before do
    if vcr = metadata[:vcr]
      if vcr.is_a?(Hash)
        cassette = vcr.keys.first
        options  = vcr.values.first
      else
        cassette = vcr
        options  = {}
      end

      VCR.insert_cassette cassette, options
    end

    DatabaseCleaner.clean_with(:truncation)
  end

  after do
    if metadata[:vcr]
      VCR.eject_cassette
    end
  end
end

# Uncomment if you want Capybara in accceptance/integration tests
#require "minitest/rails/capybara"

# Uncomment if you want awesome colorful output
# require "minitest/pride"

class MiniTest::Rails::ActiveSupport::TestCase
  # Add more helper methods to be used by all tests here...
end

# Do you want all existing Rails tests to use MiniTest::Rails?
# Comment out the following and either:
# A) Change the require on the existing tests to `require "minitest_helper"`
# B) Require this file's code in test_helper.rb

# MiniTest::Rails.override_testunit!
