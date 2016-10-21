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

  # Methods


end
