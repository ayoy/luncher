require 'test_helper'

class VendorTest < ActiveSupport::TestCase
  test "should not create vendor without name" do
    vendor = Vendor.new
    assert !vendor.save, "Saved vendor without a name"
  end
  
  test "should not create vendor with existing name" do
    vendor = vendors(:PizzaHut)
    vendor.save
    vendor.id += 1
    assert !vendor.save, "Saved vendor with already existing name"
  end

  test "notification sent today" do
    vendor = vendors(:PizzaHut)
    vendor.notification_sent_on = Date.current
    assert vendor.notification_sent_today?, "Notification was sent today"
  end

  test "notification wasnt sent today" do
    vendor = vendors(:McDonald)
    assert !vendor.notification_sent_today?, "Notification wasnt sent this day"
  end

end
