require 'test_helper'

class SessionsHelperTest < ActionView::TestCase

  def setup
    @user = users(:good)
    log_in(@user)
    remember(@user)
  end

end