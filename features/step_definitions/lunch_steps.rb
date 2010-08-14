Given /^the following lunches for (.+):$/ do |date,lunches|
  lunches.hashes.each do |hash|
    hash[:date] = Chronic.parse(date).to_date
  end
  Lunch.create!(lunches.hashes)
end

Given /^there are lunches named (.+) from "(.+)"$/ do |names, vendor|
  names.split(', ').each do |name|
    Lunch.create!(:name => name,
                  :date => Date.current,
                  :description => name,
                  :vendor_id => Vendor.first(:conditions => {:name => vendor}).id)
  end
end

Then /^I should have (\d+) lunch(?:|es)$/ do |count|
  Lunch.count.should == count.to_i
end

Then /^orders for "([^"]*)" for (.+) should be (complete|incomplete)$/ do |lunch,date,state|
  case state
  when "complete"
    Lunch.first(:conditions => {:description => lunch, :date => Chronic.parse(date).to_date}).orders.all?(&:complete).should == true
  when "incomplete"
    Lunch.first(:conditions => {:description => lunch, :date => Chronic.parse(date).to_date}).orders.all?(&:complete).should == false
  end
end

