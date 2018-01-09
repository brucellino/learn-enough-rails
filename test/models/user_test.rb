require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(name: "Mr Example", email: "example@here.com", password: "foobar_radness", password_confirmation: "foobar_radness")
  end

  test "User should be valid" do
    assert @user.valid?
  end

  test "Name should be present" do
    @user.name = "        "
    assert_not @user.valid?
  end

  test "Email should be present" do
    @user.email = "      "
    assert_not @user.valid?
  end

  test "Name should not be too long" do
    @user.name = 'a'*51
    assert_not @user.valid?
  end

  test "Email Address should not be too long" do
    @user.email = 'a'*244 + '@example.com'
    assert_not @user.valid?
  end

  test "Email addresses should have the correct format" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |address|
        @user.email = address
        assert @user.valid?, "#{address.inspect} should be valid"
    end
  end

  test "Invalid email addresses should be rejected" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foobar@bar+baz.com]

    invalid_addresses.each do |invalid_address|
      @user.email = invalid_addresses
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid."
    end
  end

  test "Duplicate users are invalid" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "Email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "Emails should be saved in lower-case" do
      mixed_case_email = "MyEmailIsRad@RadHouse.Radness.Org"
      @user.email = mixed_case_email
      @user.save
      assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "Password should be present " do
    @user.password = @user.password_confirmation = " "*10
    @user.save
    assert_not @user.valid?
  end

  test "Password minimum length test" do
    @user.password = @user.password_confirmation = "a"*5
    @user.save
    assert_not @user.valid?
  end

end
