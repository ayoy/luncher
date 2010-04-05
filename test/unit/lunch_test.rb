require 'test_helper'

class LunchTest < ActiveSupport::TestCase
  test "should not save lunch without date" do
    lunch = lunches(:without_date)
    assert !lunch.save, "Saved the lunch without a date"
  end

  test "should not save lunch without vendor" do
    lunch = lunches(:without_vendor)
    assert !lunch.save, "Saved the lunch without a vendor"
  end

  test "should not save lunch without name" do
    lunch = lunches(:without_name)
    assert !lunch.save, "Saved the lunch without a name"
  end

  test "should not save lunch without description" do
    lunch = lunches(:without_description)
    assert !lunch.save, "Saved the lunch without a description"
  end
  
  test "should save lunch without price" do
    lunch = lunches(:without_price)    
    assert lunch.save, "Failed to save the lunch without a price"
  end
  
  test "should be refundable by default" do
    lunch = lunches(:one)
    assert lunch.refundable, "Lunch is not refundable by default"
  end

  test "should assign a default price for lunch without price" do
    lunch = lunches(:without_price)
    assert_equal lunch.price, 5, "Default price is incorrect"
  end

  test "should increase the price when saving refundable lunch" do
    lunch = lunches(:without_price)
    lunch.save
    assert_equal lunch.price, 10, "Non-refunded price is incorrect"
  end

  test "should not increase the price when saving non-refundable lunch" do
    lunch = lunches(:without_price)
    lunch.refundable = false
    lunch.save
    assert_equal lunch.price, 5, "Non-refunded price is incorrect"
  end
end
