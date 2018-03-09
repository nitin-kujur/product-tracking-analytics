require 'test_helper'

class LineItemControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get line_item_index_url
    assert_response :success
  end

end
