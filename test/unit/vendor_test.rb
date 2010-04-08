require 'test_helper'

class VendorTest < ActiveSupport::TestCase
  test "should not create vendor without name" do
    vendor = Vendor.new
    assert !vendor.save, "Saved vendor without a name"
  end
  
  test "should not create vendor with existing name" do
    vendor = vendors(:one)
    vendor.save
    other_vendor = vendors(:one)
    assert !other_vendor.save, "Saved vendor with already existing name"
  end
end
