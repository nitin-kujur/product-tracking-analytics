require 'test_helper'

class Analyticapi::PremiumControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get analyticapi_premium_index_url
    assert_response :success
  end

end
