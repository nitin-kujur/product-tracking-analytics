require 'test_helper'

class CustomerCustomerTagControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get customer_customer_tag_index_url
    assert_response :success
  end

end
