require 'test_helper'

class ProductProductTagControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get product_product_tag_index_url
    assert_response :success
  end

end
