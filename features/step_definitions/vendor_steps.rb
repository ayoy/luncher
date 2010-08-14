Given /^there is a vendor called "(.+)"$/ do |name|
  Vendor.create!(:name => name)
end

Given /^the following vendors:$/ do |vendors|
  Vendor.create!(vendors.hashes)
end

Given /^I have 0 vendors$/ do
  Vendor.delete_all
end

Given /^notification was sent for "([^"]*)" (.+)$/ do |name, date|
  Vendor.first(:conditions => {:name => name}).update_attribute(:notification_sent_on, Chronic.parse(date).to_date)
end

When /^I delete the (\d+)(?:st|nd|rd|th) vendor$/ do |pos|
  within("table tr:nth-child(#{pos.to_i})") do
    click_link "Remove"
  end
end

When /^I edit the (\d+)(?:st|nd|rd|th) vendor$/ do |pos|
  within("table tr:nth-child(#{pos.to_i})") do
    click_link "Edit"
  end
end

When /^I click "([^"]*)" for the (\d+)(?:st|nd|rd|th) vendor on the list$/ do |link, pos|
  within("table tr:nth-child(#{pos.to_i})") do
    click_link link
  end
end
  
Then /^I should see the following vendors:$/ do |expected_vendors_table|
  expected_vendors_table.diff!(tableish('table tr', 'td'))
end

Then /^I should have (\d+) vendor(?:s?)$/ do |count|
  Vendor.count.should == count.to_i
end

Then /^the (\d+)(?:st|nd|rd|th) vendor should be named "([^"]*)"$/ do |pos, name|
  within("table tr:nth-child(#{pos.to_i})") do |content|
    content.should contain(name)
  end
end

Then /^I should see "([^"]*)" for the (\d+)(?:st|nd|rd|th) vendor on the list$/ do |text, pos|
  within("table tr:nth-child(#{pos.to_i})") do |content|
    content.should contain(text)
  end
end

Then /^I should not see "([^"]*)" for the (\d+)(?:st|nd|rd|th) vendor on the list$/ do |text, pos|
  within("table tr:nth-child(#{pos.to_i})") do |content|
    content.should_not contain(text)
  end
end
