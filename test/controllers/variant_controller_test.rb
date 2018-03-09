require 'test_helper'

class VariantControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get variant_index_url
    assert_response :success
  end

end
