require 'test_helper'

class OpenfindControllerTest < ActionController::TestCase
  test "should get dl_member" do
    get :dl_member
    assert_response :success
  end

  test "should get dl_template" do
    get :dl_template
    assert_response :success
  end

end
