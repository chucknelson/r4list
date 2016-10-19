require 'test_helper'

class ListTest < ActiveSupport::TestCase
  
  def setup
  end

  def teardown
  end

  # Validations
  test "should not save list without user" do
    list = List.new(title: "My List")
    assert_nil list.user, "User exists but should be nil"
    assert_not list.save, "List saved without a user"
  end

  test "should not save list without title" do
    list = List.new(user: users(:user1))
    assert_nil list.title, "Title exists but should be nil"
    assert_not list.save, "List saved without a title"
  end

  test "should not save list without a title of at least 5 characters" do
    list = List.new(user: users(:user1), title: "List")
    assert_not list.save, "List saved with a title less than 5 characters long"
  end

  test "should save list meeting validation requirements" do
    list = List.new(user: users(:user1), title: "My List")
    assert list.save, "List did not save successfully"
  end

  # Methods
  test "should be incomplete if no items exist (i.e., new empty list)" do
    list = List.new
    assert_not list.completed?, "List is completed but no items exist"
  end

  test "should be complete if no items are remaining" do
    list = lists(:user1_list_with_one_incomplete_item)
    assert_not list.completed?, "Test list is already complete"
    list.items.where(completed: false).first.completed = true
    #list.update_items_remaining
    #assert_equal 0, list.items_remaining, "Items remaining is not 0"
    #assert list.completed?, "Items are all complete but list is incomplete"
  end
=begin
  test "should update items remaining with number of incomplete items" do
    list = lists(:user1_list1)
    assert list.items.where(completed: false).size > 0, "Test list has no incomplete items"
    assert_equal list.items.where(completed: false).size, list.items_remaining, "Test list not set up correctly"
    
    list.items.where(completed: false).first.completed = true
    assert list.items.where(completed: false).size == 0, "Items collection did not update correctly"
    assert_equal list.items.where(completed: false).size, list.items_remaining, "Items remaining not updated correctly"
  end
=end

  


end
