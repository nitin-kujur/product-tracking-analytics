require 'test_helper'

class OrderOrderTagControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get order_order_tag_index_url
    assert_response :success
  end

end
