require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test 'layout links' do
    # These tests will check whether the layout is correct.
    # The root page as well as links are tested.

    # Get the root page
    get root_path

    assert_template 'static_pages/home'

    # check whether the links are correct.
    assert_select 'a[href=?]', root_path, count: 1
    # Check that there's a link to help
    assert_select 'a[href=?]', help_path
    # Check that there's a link to about
    assert_select 'a[href=?]', about_path
    # Check that there's a link to contact
    assert_select 'a[href=?]', contact_path
  end
end
