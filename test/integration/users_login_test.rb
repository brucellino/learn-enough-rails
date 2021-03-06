require 'test_helper'
require 'awesome_print'
class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:good)
    puts "User is #{@user.email}"
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
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path, count: 1
    assert_select "a[href=?]", user_path(@user)
  end

  test "login with valid info can also log out" do
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end

  test "login with valid information followed by logout" do
    get login_path
    post login_path, params: { session: { email:    @user.email,
                                          password: 'good_password_good' } }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    # Simulate a user clicking logout in a second window.
    delete logout_path
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end

  test "login with remembering" do
    log_in_as(@user, remember_me: '1') 
    #assert_not_empty cookies['remember_token']
    assert_nil cookies['remember_token'], assigns(:user).remember_digest
  end

  test "login without remembering" do
    # Log in to set the cookie
    log_in_as(@user, remember_me: '1') 
    # Log in again check that the cookie is deleted
    log_in_as(@user, remember_me: '0')
    assert_nil cookies['remember_token']
  end
end