require 'test_helper'

class PostExamplesControllerTest < ActionController::TestCase
  setup do
    @post_example = post_examples(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:post_examples)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create post_example" do
    assert_difference('PostExample.count') do
      post :create, post_example: { json_string: @post_example.json_string, name: @post_example.name, user_id: @post_example.user_id }
    end

    assert_redirected_to post_example_path(assigns(:post_example))
  end

  test "should show post_example" do
    get :show, id: @post_example
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @post_example
    assert_response :success
  end

  test "should update post_example" do
    patch :update, id: @post_example, post_example: { json_string: @post_example.json_string, name: @post_example.name, user_id: @post_example.user_id }
    assert_redirected_to post_example_path(assigns(:post_example))
  end

  test "should destroy post_example" do
    assert_difference('PostExample.count', -1) do
      delete :destroy, id: @post_example
    end

    assert_redirected_to post_examples_path
  end
end
