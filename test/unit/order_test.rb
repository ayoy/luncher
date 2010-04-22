require 'test_helper'

class OrderTest < ActiveSupport::TestCase

  test "should not save order without lunch_id" do
    order = Factory.build(:order, :lunch => nil)
    assert !order.save, "Saved order without a lunch_id"
  end

  test "should not save order without user_id" do
    order = Factory.build(:order, :user => nil)
    assert !order.save, "Saved order without a user_id"
  end

  test "should save order without total price" do
    order = Factory.build(:order)
    assert order.save, "Failed to save order without a total price"
  end

  test "should assign a default total price for lunch without total price" do
    order = Factory(:order)
    assert_equal 0, order.total, "Default total price is incorrect"
  end
end
