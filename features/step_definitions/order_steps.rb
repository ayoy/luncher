###
### helpers
###

def orders_by_user_and_date(user, date)
  Order.by_user(User.first(:conditions => {:login => user})).by_date(date)
end

def radio_button_id(lunch_name)
  "order_lunch_id_#{Lunch.all_for_today.first(:conditions => {:description => lunch_name}).id}"
end

###
### steps
###

Given /^user "([^"]*)" has the balance equal to (\d+)$/ do |username, balance|
  User.first(:conditions => {:login => username}).update_attribute(:balance, balance)
end

Given /^system is (locked|unlocked)$/ do |state|
  case state
  when "locked"
    Setting.toggle_system_locked(true)
  when "unlocked"
    Setting.toggle_system_locked(false)
  end
end

Given /^the following orders:$/ do |orders|
  Order.create!(orders.hashes)
end

Given /^I have (\d+) orders for the current date$/ do |count|
  orders_by_user_and_date("john", Date.current).count.should == count.to_i
end

Given /^lunches are refundable by (\d+)$/ do |amount|
  Setting.instance.update_attribute(:money_refunded_per_lunch, amount)
end

Given /^there (?:is|are) (\d+) refundable lunch(?:|es) per day$/ do |amount|
  Setting.instance.update_attribute(:refunded_lunches_per_day, amount)
end

When /^I choose "([^"]*)" from the lunches list$/ do |name|
  choose(radio_button_id(name))
end

Then /^I should have (\d+) orders? for the current date$/ do |count|
  orders_by_user_and_date("john", Date.current).count.should == count.to_i
end

Then /^I should have (\d+) orders?$/ do |count|
  Order.count.should == count.to_i
end

Then /^it should be named "([^"]*)"$/ do |name|
  order = orders_by_user_and_date("john", Date.current).first
  Lunch.find(order.lunch_id).description.should == name
end

Then /^the radio button for "([^\"]*)" should be disabled$/ do |name|
  field_with_id(radio_button_id(name)).should be_disabled
end

Then /^the submit button should be disabled$/ do
  field_with_id("order_submit").should be_disabled
end

When /^I delete the (\d+)(?:st|nd|rd|th) order$/ do |pos|
  within("tbody tr:nth-child(#{pos.to_i})") do
    click_link "Cancel order"
  end
end

Then /^I should see the following orders:$/ do |expected_orders_table|
  expected_orders_table.diff!(tableish('tbody tr', 'td'))
end

Then /^I should see the following lunches:$/ do |expected_lunches_table|
  expected_lunches_table.diff!(tableish('tbody tr', 'td'))
end
