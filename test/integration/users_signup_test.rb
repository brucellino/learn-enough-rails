require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "invalid signup" do
    
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: 
                                  { name:  "",
                                    email: "user@invalid",
                                    password:              "foo",
                                    password_confirmation: "bar" } 
                               }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.alert'
  end
  
  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "passwordpassword",
                                         password_confirmation: "passwordpassword" } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.danger
  end
end
