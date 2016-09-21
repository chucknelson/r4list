require 'test_helper'

class ListsControllerTest < ActionController::TestCase

  def setup
    @user = users(:user1)
    init_user_session(@user)
  end

  test "should route to user lists with /lists and /users/:id/lists" do
    assert_routing "/lists", {controller: "lists", action: "index"}
    assert_routing "/users/#{@user.id}/lists", {controller: "lists", action: "index", user_id: "#{@user.id}"}
  end

  test "should have user with lists that have items" do
    get :index, nil
    assert_response :success

    user_lists = assigns(:lists)
    assert user_lists.count > 0

    first_list = user_lists.first
    assert first_list.items_remaining > 0
    assert_equal first_list.items_remaining, first_list.items.where(completed: false).count
  end

  test "should create list successfully" do
    new_list = List.new(title: "New List")
    post :create, {user_id: @user.id, list: {title: new_list.title}}
    assert_response :redirect

    # Verify saved state
    created_list = List.last
    assert_equal new_list.title, created_list.title
    assert_equal 0, created_list.items_remaining
    assert_equal true, created_list.completed?
  end

  def teardown
    # nothing yet
  end

end
