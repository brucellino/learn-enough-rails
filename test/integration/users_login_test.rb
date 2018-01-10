require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  test "Login with valid information" do
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
end
