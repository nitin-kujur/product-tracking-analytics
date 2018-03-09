require 'test_helper'

class ProductTagControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get product_tag_index_url
    assert_response :success
  end

end
