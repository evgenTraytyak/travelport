module CredentialsHelper

  # Command: sets test API credentials
  def set_test_api_credentials
    Travelport.setup do |config|
      config.username = test_username
      config.password = test_password
      config.target_branch = test_branch_code
      config.point_of_sale = test_point_of_sale
      config.endpoint = test_endpoint
    end
  end

  # Returns true if real test credentials have been configured
  def real_api_credentials_available?
    if real_test_username && real_test_password
      STDERR.puts %{
NOTE: real api_credentials are configured so if the integration tests are missing request cassettes,
live queries will be performed to record the actual interaction.
      }
      true
    else
      STDERR.puts %{
NOTE: real API credentials are not configured so if the integration tests are missing request cassettes,
they will fail. Set real API credentials with environment variables:

  export TEST_TRAVELPORT_USERNAME="Universal API/uAPI0000000000-00000000"
  export TEST_TRAVELPORT_PASSWORD="0000000000000000000000000"
  export TEST_TRAVELPORT_BRANCH_CODE=P0000000
  export TEST_TRAVELPORT_POS=uAPI

      }
      false
    end
  end

  # Returns the username to use for tests
  def test_username
    real_test_username || 'fakeusername'
  end
  def real_test_username
    ENV['TEST_TRAVELPORT_USERNAME']
  end

  # Returns the username to use for tests
  def test_password
    real_test_password || 'fakepassword'
  end
  def real_test_password
    ENV['TEST_TRAVELPORT_PASSWORD']
  end

  def test_branch_code
    ENV['TEST_TRAVELPORT_BRANCH_CODE'] || 'P0000000'
  end

  def test_point_of_sale
    ENV['TEST_TRAVELPORT_POS'] || 'uAPI'
  end

  def test_endpoint
    ENV['TEST_TRAVELPORT_ENDPOINT'] || 'https://emea.copy-webservices.travelport.com/B2BGateway/connect/uAPI/Service'
  end

end

RSpec.configure do |conf|
  conf.extend CredentialsHelper
  conf.include CredentialsHelper
end