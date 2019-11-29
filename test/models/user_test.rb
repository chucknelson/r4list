require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    # default test instances
    @new_user = User.new(name: "My User", email: "myuser@myuser.com", password: "password", password_confirmation: "password")
    @test_user = users(:user1)
  end

  def teardown
  end

  # Associations
  test "should have many lists" do
    user = @test_user
    assert user.lists.size > 1, "User does not have many (> 1) lists"
  end

  test "should destroy associated lists if user destroyed" do
    user = @test_user
    assert_not_nil List.find_by(user_id: user.id), "User has no lists"
    assert user.destroy, "User not destroyed"
    assert_nil List.find_by(user_id: user.id), "User still has lists"
  end

  # Validations
  test "should not save user without credentials (i.e., is bcrypt/has_secure_password working)" do
    user = @new_user
    user.password_confirmation = "" # i.e., blank form field
    assert_not user.save, "User saved without a password confirmation"
  end

  test "should not save user without a name" do
    user = @new_user
    user.name = nil
    assert_nil user.name, "User name exists but should be nil"
    assert_not user.save, "User saved without a name"
  end

  test "should not save user without an email" do
    user = @new_user
    user.email = nil
    assert_nil user.email, "User email exists but should be nil"
    assert_not user.save, "User saved without an email"
  end

  test "should not save user if email already exists in database" do
    user = @new_user
    user.email = @test_user.email
    assert_equal @test_user.email, user.email, "User email not set correctly (should match test user)"
    assert_not user.save, "User saved with an email that already exists in the database"
  end

  test "should save user that passes validations" do
    user = @new_user
    assert user.save, "User did not save successfully"
  end

  # Callbacks
  # N/A

  # Methods (not used in callbacks)
  test "should authenticate with a correct password (i.e., is bcrypt/has_secure_password working)" do
    user = @test_user
    assert_not user.authenticate("incorrect password"), "User authenticated with an incorrect password"
    assert user.authenticate("password"), "User did not authenticate as expected"
  end

end
