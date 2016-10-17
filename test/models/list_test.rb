require 'test_helper'

class ListTest < ActiveSupport::TestCase
  
  def setup
  end

  def teardown
  end

  # Test Validations
  test "should not save list without user" do
    list = List.new(title: "My List")
    assert_nil list.user, "User exists but should be nil"
    assert !list.save, "List saved without a user"
  end

  test "should not save list without title" do
    list = List.new(user: users(:user1))
    assert_nil list.title, "Title exists but should be nil"
    assert !list.save, "List saved without a title"
  end

  test "should not save list without a title of at least 5 characters" do
    list = List.new(user: users(:user1), title: "List")
    assert !list.save, "List saved with a title less than 5 characters long"
  end

  test "should save list meeting validation requirements" do
    list = List.new(user: users(:user1), title: "My List")
    assert list.save
  end

  


end
