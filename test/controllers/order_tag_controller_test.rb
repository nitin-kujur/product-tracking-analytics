require 'test_helper'

class OrderTagControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get order_tag_index_url
    assert_response :success
  end

end
