require 'test_helper'

class ApiControllerTest < ActionController::TestCase
  test "should get orders" do
    get :orders
    assert_response :success
  end

end
