require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "should assign default balance when user created without balance" do
    user = Factory(:user)
    assert_equal user.balance, 0, "Default balance is incorrect"
  end

  test "should return full name as last name and first name" do
    user = Factory(:user, :first_name => "Johson", :last_name => "Ben")
    assert_equal "Ben Johson", user.full_name 
                 "Full name is different than last_name-space-first_name"
  end
end
