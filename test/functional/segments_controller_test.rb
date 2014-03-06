require 'test_helper'

class SegmentControllerTest < ActionController::TestCase

  def setup
    @controller = Segment.new
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get edit" do
    get :edit
    assert_response :success
  end

  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get update" do
    get :update
    assert_response :success
  end

  test "should get destory" do
    get :destory
    assert_response :success
  end

end
