require "test_helper"

class Admin::OrderDeralisControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get admin_order_deralis_update_url
    assert_response :success
  end
end
