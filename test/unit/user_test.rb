require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should assign default balance when user created without balance" do
    user = users(:ben)
    assert_equal user.balance, 0, "Default balance is incorrect"
  end

  test "should return full name as last name and first name" do
    user = users(:ben)
    assert_equal user.full_name, "Johnson Ben",
                 "Full name is different than last_name-space-first_name"
  end
end
