require 'test_helper'

class ItemsControllerTest < ActionController::TestCase
  
  def setup
    # Defaults
    @user = users(:user1)
    @list = lists(:user1_list1)
    init_user_session(@user)
  end

  def teardown
  end

  test "should create new item successfully" do
    expected_items_count = @list.items.count + 1
    expected_item_remaining_count = @list.items.where(completed: false).count + 1

    post :create, {user_id: @user.id, list_id: @list.id, item: {name: "New Item", completed: false}}
    assert_response :redirect
    
    assert_equal expected_items_count, @list.items.count # reload not required because items.count is triggering a query (i.e., value isn't assigned anywhere yet)
    assert_equal expected_item_remaining_count, @list.reload.items_remaining # reload required because @list is already fetched (from setup method)
  end

  test "should update item successfully" do
    item = get_incomplete_item(@list)
    updated_name = "Updated Name"
    patch :update, {format: 'js', user_id: @user.id, list_id: @list.id, id: item.id, item: {name: updated_name}}
    assert_response :success

    assert_equal updated_name, item.reload.name
  end

  test "should complete item successfully" do
    expected_item_remaining_count = @list.items.where(completed: false).count - 1

    item = get_incomplete_item(@list)
    patch :update, {format: 'js', user_id: @user.id, list_id: @list.id, id: item.id, item: {completed: true}}
    assert_response :success

    assert_equal expected_item_remaining_count, @list.reload.items_remaining
  end

  test "should delete item successfully" do
    expected_items_count = @list.items.count - 1
    expected_item_remaining_count = @list.items.where(completed: false).count - 1

    item = get_incomplete_item(@list)
    delete :destroy, {user_id: @user.id, list_id: @list.id, id: item.id}
    assert_response :redirect
    assert_equal "Item deleted", flash[:notice]

    assert_equal expected_items_count, @list.items.count
    assert_equal expected_item_remaining_count, @list.reload.items_remaining
  end

  test "should not update the item if list items remaining update fails" do
    #TODO
  end

end
