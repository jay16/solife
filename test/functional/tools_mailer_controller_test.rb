require 'test_helper'

class ToolsMailerControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get edit" do
    get :edit
    assert_response :success
  end

  test "should get update" do
    get :update
    assert_response :success
  end

  test "should get destroy" do
    get :destroy
    assert_response :success
  end

  test "should get pop" do
    get :pop
    assert_response :success
  end

  test "should get smtp" do
    get :smtp
    assert_response :success
  end

end
