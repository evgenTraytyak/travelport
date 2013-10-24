require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = "spec/fixtures/cassettes"
  c.hook_into               :fakeweb
  # Need to encode, unfortunately URI.encode doesn't do '/' as expected
  c.filter_sensitive_data('<USERNAME>') { (ENV['TEST_TRAVELPORT_USERNAME'] || 'fakeusername').gsub('/','%2F').gsub(/\s/,'%20') }
  c.filter_sensitive_data('<PASSWORD>') { (ENV['TEST_TRAVELPORT_PASSWORD'] || 'fakepassword').gsub('/','%2F').gsub(/\s/,'%20') }
end

require 'travelport'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.extend VCR::RSpec::Macros

  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  # config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  # config.use_transactional_fixtures = true

  config.before :each do
    set_test_api_credentials
  end
end