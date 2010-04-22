require 'test_helper'

class LunchTest < ActiveSupport::TestCase
  test "should save lunch without date" do
    lunch = Factory(:lunch, :date => nil)
    assert !lunch.new_record?, "Failed to save the lunch without a date"
  end

  test "should not save lunch without vendor" do
    lunch = Factory.build(:lunch, :vendor => nil)
    assert !lunch.save, "Saved the lunch without a vendor"
  end

  test "should not save lunch without name" do
    lunch = Factory.build(:lunch, :name => nil)
    assert !lunch.save, "Saved the lunch without a name"
  end

  test "should not save lunch without description" do
    lunch = Factory.build(:lunch, :description => nil)
    assert !lunch.save, "Saved the lunch without a description"
  end
  
  test "should save lunch without price" do
    lunch = Factory(:lunch, :price => nil)
    assert lunch.save, "Failed to save the lunch without a price"
  end
  
  test "should be refundable by default" do
    lunch = Factory(:lunch)
    assert lunch.refundable, "Lunch is not refundable by default"
  end

  test "should assign a default price for lunch without price" do
    lunch = Factory(:lunch)
    assert_equal lunch.price, 10, "Default price is incorrect"
  end

  test "should not save two lunches with the same name in one day" do
    lunch = Factory(:lunch)
    same_name = lunch.name

    assert lunch.valid?, "Validation should have been successful"

    lunch = Factory.build(:lunch, :name => same_name)
    assert !lunch.save, "Shouldn't have saved two lunches with the same name for one date"
  end

end
