require 'test_helper'

class LunchTest < ActiveSupport::TestCase
  test "should save lunch without date" do
    lunch = lunches(:without_date)
    assert lunch.save, "Failed to save the lunch without a date"
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
    assert_equal lunch.price, 10, "Default price is incorrect"
  end

  test "should not save two lunches with the same name in one day" do
    lunch = lunches(:without_price)
    same_name = 'test name'
    lunch.name = same_name;
    assert lunch.save

    lunch = lunches(:one)
    lunch.name = same_name;
    assert !lunch.save, "Two lunches with the same name in one day arent allowed"
  end

end
