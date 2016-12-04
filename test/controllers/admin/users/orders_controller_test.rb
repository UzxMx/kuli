require 'test_helper'

class Admin::Users::OrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_users_orders_index_url
    assert_response :success
  end

end
