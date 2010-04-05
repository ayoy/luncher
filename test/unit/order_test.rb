require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "should not save order without lunch_id" do
    order = orders(:without_lunch_id)
    assert !order.save, "Saved order without a lunch_id"
  end

  test "should not save order without user_id" do
    order = orders(:without_user_id)
    assert !order.save, "Saved order without a user_id"
  end

  test "should save order without total price" do
    order = orders(:without_total)
    assert order.save, "Failed to save order without a total price"
  end

  test "should assign a default total price for lunch without total price" do
    order = orders(:without_total)
    assert_equal order.total, 0, "Default total price is incorrect"
  end
end
