require 'test_helper'

class ListTest < ActiveSupport::TestCase
  
  def setup
    # default test instances
    @test_user = users(:user1)
    @test_list = lists(:user1_list1)
  end

  def teardown
  end

  # Associations
  test "should belong to users" do
    user = @test_user
    assert_not_nil user.lists, "User has no lists / lists not belonging to user"
  end

  test "should have many items" do
    list = @test_list
    assert list.items.size > 1, "List does not have many (> 1) items"
  end

  test "should destroy associated items if list destroyed" do
    list = @test_list
    assert_not_nil Item.find_by(list_id: list.id), "List has no items"

    list.destroy

    assert list.destroyed?, "List not destroyed"
    assert_nil Item.find_by(list_id: list.id), "List still has items"
  end

  # Validations
  test "should not save list without user" do
    list = List.new(title: "My List")
    assert_nil list.user, "User exists but should be nil"
    assert_not list.save, "List saved without a user"
  end

  test "should not save list without title" do
    list = List.new(user: @test_user)
    assert_nil list.title, "Title exists but should be nil"
    assert_not list.save, "List saved without a title"
  end

  test "should not save list without a title of at least 5 characters" do
    list = List.new(user: @test_user, title: "List")
    assert_not list.save, "List saved with a title less than 5 characters long"
  end

  test "should save list that passes validations" do
    list = List.new(user: @test_user, title: "My List")
    assert list.save, "List did not save successfully"
  end

  # Methods
  test "should be incomplete if no items exist (i.e., new empty list)" do
    list = List.new
    assert_not list.completed?, "List is completed but no items exist"
  end

  test "should be complete if no items are remaining" do
    list = @test_list
    assert_not list.completed?, "Test list is already complete"

    list.items.where(completed: false).each { |item| item.update(completed: true) }
    list.update_items_remaining
    
    assert_equal 0, list.items_remaining, "Items remaining is not 0"
    assert list.completed?, "Items are all complete but list is incomplete"
  end

  test "should update items remaining with number of incomplete items" do
    list = @test_list
    assert list.items.where(completed: false).size > 0, "Test list has no incomplete items"
    assert_equal list.items.where(completed: false).size, list.items_remaining, "Test list not set up correctly"
    expected_items_remaining = list.items_remaining - 1
    
    list.items.where(completed: false).first.update(completed: true)
    list.update_items_remaining

    assert_equal list.items_remaining, list.items.where(completed: false).size, "Items remaining out of sync with individual items"
    assert_equal expected_items_remaining, list.items_remaining, "Items remaining not updated correctly"
  end

end
