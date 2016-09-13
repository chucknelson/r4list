require 'test_helper'

class ItemsControllerTest < ActionController::TestCase
  
  def setup
    # Defaults
    @user = users(:user1)
    @list = lists(:user1_list1)
    @item = items(:user1_list1_item1) 
  end

  def teardown
  end

  test "should create item successfully" do
    expected_items_count = @list.items.count + 1
    expected_item_remaining_count = @list.items.where(completed: false).count + 1

    new_item = Item.new(name: "New Item", completed: false)
    post :create, {user_id: @user.id, list_id: @list.id, item: {name: @item.name, completed: @item.completed}}, {user_id: @user.id}
    assert_response :redirect

    @list.reload
    assert_equal expected_items_count, @list.items.count
    assert_equal expected_item_remaining_count, @list.items_remaining
  end

  test "should delete item successfully" do
    expected_items_count = @list.items.count - 1
    expected_item_remaining_count = @list.items.where(completed: false).count - 1

    delete :destroy, {user_id: @user.id, list_id: @list.id, id: @item.id}, {user_id: @user.id}
    assert_response :redirect
    assert_equal "Item deleted", flash[:notice]
    @list.reload

    assert_equal expected_items_count, @list.items.count
    assert_equal expected_item_remaining_count, @list.items_remaining
  end

  test "should update item successfully" do
    updated_name = "Updated Name"
    patch :update, {format: 'js', user_id: @user.id, list_id: @list.id, id: @item.id, item: {name: updated_name}}, {user_id: @user.id}
    assert_response :success

    @item.reload
    assert_equal updated_name, @item.name
  end

  test "should decrease remaining list items when item completed" do
    # Verify and record starting conditions
    assert_not @item.completed, "This test requires an incomplete item, but item is complete" 
    assert_equal @list.items.where(completed: false).count, @list.items_remaining
    items_remaining_start = @list.items_remaining

    # Update item to completed
    patch :update, {format: 'js', user_id: @user.id, list_id: @list.id, id: @item.id, item: {completed: true}}, {user_id: @user.id}
    assert_response :success
    @list.reload

    # Verify updates happened as expected
    assert_equal items_remaining_start - 1, @list.items_remaining
    assert_equal @list.items.where(completed: false).count, @list.items_remaining
  end

  test "should increase remaining list items when item is not completed" do
    # Verify and record starting conditions
    @item = items(:user1_list1_item2)
    assert @item.completed, "This test requires a complete item, but item is incomplete" 
    assert_equal @list.items.where(completed: false).count, @list.items_remaining
    items_remaining_start = @list.items_remaining

    # Update item to completed
    patch :update, {format: 'js', user_id: @user.id, list_id: @list.id, id: @item.id, item: {completed: false}}, {user_id: @user.id}
    assert_response :success
    @list.reload

    # Verify updates happened as expected
    assert_equal items_remaining_start + 1, @list.items_remaining
    assert_equal @list.items.where(completed: false).count, @list.items_remaining
  end

  test "should not impact remaining list items when updating name only" do
    assert_not @item.completed, "This test requires an incomplete item, but item is complete"
    expected_items_remaining_count = @list.items_remaining

    updated_name = "Updated Name"
    patch :update, {format: 'js', user_id: @user.id, list_id: @list.id, id: @item.id, item: {name: updated_name}}, {user_id: @user.id}
    assert_response :success
    @item.reload
    @list.reload

    assert_equal updated_name, @item.name
    assert_equal expected_items_remaining_count, @list.items_remaining
    assert_equal expected_items_remaining_count, @list.items.where(completed: false).count
  end

  

end
