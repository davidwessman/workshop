ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require "codeclimate-test-reporter"
require "capybara"
require "rspec/example_steps"

CodeClimate::TestReporter.start

# Add additional requires below this line. Rails is not loaded until this point!

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!

  config.include Devise::TestHelpers, type: :controller
  Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
  config.include ControllerMacros
  config.extend ControllerMacros, type: :controller
  Dir[Rails.root.join('spec/page_objects/**/*.rb')].each { |f| require f }
  def build(*args)
    FactoryGirl.build(*args)
  end

  def create(*args)
    FactoryGirl.create(*args)
  end

  def attributes_for(*args)
    FactoryGirl.attributes_for(*args)
  end

  # Database cleaning
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, js: true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
