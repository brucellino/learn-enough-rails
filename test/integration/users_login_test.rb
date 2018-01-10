require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:good)
  end

  test "Login with invalid information" do
    get login_path
    assert_template "sessions/new"
    post login_path, params: { session: {email: "", password: "" } }
    assert_template "sessions/new"
    assert_not flash.empty?
    
    # if we provide incorrect login information, the flash
    # should  disappear after one showing
    get root_path
    assert flash.empty?
  end

  test "Login in with valid information" do
    get login_path
    post login_path, params: { session: { email: @user.email, 
                                          password: 'good_password_good' } }
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path, count: 1
    assert_select "a[href=?]", user_path(@user)
  end
end
