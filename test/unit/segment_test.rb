require 'test_helper'

class SegmentTest < ActiveSupport::TestCase
  def setup
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:segments)
  end
end
