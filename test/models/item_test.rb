require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  
  def setup
    # default test instances
    @test_list = lists(:user1_list1)
    @test_incomplete_item = @test_list.items.where(completed: false).first
    @test_completed_item = @test_list.items.where(completed: true).first
    @new_item = Item.new(name: "My Item", completed: false, sort_order: 9, list: @test_list)
  end
  
  def teardown
  end

  # Associations
  test "should belong to list" do
    list = @test_list
    assert_not_nil list.items, "List has no items / items not belonging to list"
  end

  # Validations
  test "should not save item without list" do
    item = @new_item
    item.list = nil
    assert_nil item.list, "List exists but should be nil"
    assert_not item.save, "Item saved without a list"
  end

  test "should not save item without name" do
    item = @new_item
    item.name = nil
    assert_nil item.name, "Name exists but should be nil"
    assert_not item.save, "Item saved without a title"
  end

  test "should save item that passes validations" do
    item = @new_item
    assert item.save, "Item did not save successfully"
  end

  # Callbacks
  test "should update list's items remaining after status change" do
    item = @test_incomplete_item
    list = item.list
    assert item.update(completed: true), "Item not updated"
    list.reload
    assert_equal list.items.where(completed: false).size, list.items_remaining, "Items remaining not updated correctly"
    
  end

  test "should not update list's items remaining after item update failure" do
    item = @test_incomplete_item
    list = item.list
    assert_not item.update(completed: true, name: nil), "Item updated unexpectedly"
    list.reload
    assert_equal list.items.where(completed: false).size, list.items_remaining, "Items remaining updated unexpectedly"
  end

  test "should update list's items remaining after item destroyed" do
    item = @test_incomplete_item
    list = item.list
    assert item.destroy, "Item not destroyed"
    list.reload
    assert_equal list.items.where(completed: false).size, list.items_remaining, "Items remaining not updated correctly"
  end

  # Methods (not used in callbacks)
  # N/A
  
end
