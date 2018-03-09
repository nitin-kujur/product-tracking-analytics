require 'test_helper'

class CustomerTagControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get customer_tag_index_url
    assert_response :success
  end

end
