require 'test_helper'

class Admin::Users::StoresControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_users_stores_index_url
    assert_response :success
  end

end
