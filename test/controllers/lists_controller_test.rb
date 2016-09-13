require 'test_helper'

class ListsControllerTest < ActionController::TestCase

  def setup
    @user = users(:user1)
  end

  test "should route to user lists" do
    assert_routing "/lists", {controller: "lists", action: "index"}
    assert_routing "/users/#{@user.id}/lists", {controller: "lists", action: "index", user_id: "#{@user.id}"}
  end

  test "user should have lists with items" do
    get :index, nil, {:user_id => @user.id}
    assert_response :success

    user_lists = assigns(:lists)
    assert user_lists.count > 0

    first_list = user_lists.first
    assert first_list.items_remaining > 0
    assert_equal first_list.items_remaining, first_list.items.where(completed: false).count
  end

  def teardown
    # nothing yet
  end

end
