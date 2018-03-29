require 'test_helper'

class Analyticapi::KippControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get analyticapi_kipp_index_url
    assert_response :success
  end

end
