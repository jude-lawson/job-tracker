require 'database_cleaner'
DatabaseCleaner[:active_record].strategy = :truncation

require 'simplecov'
SimpleCov.start

require 'capybara/rspec'
Capybara.save_path = './tmp'
require 'database_cleaner'
DatabaseCleaner[:active_record].strategy = :truncation

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  # Sets up database cleaner to clean the database before and after each test
  config.before :each do
    DatabaseCleaner.clean
  end

  config.after :each do
    DatabaseCleaner.clean
  end
end
