Given /^the following users:$/ do |users|
  User.create!(users.hashes)
end

When /^I set balance for the (\d+)(?:st|nd|rd|th) user to "([^"]*)"$/ do |pos,value|
  within("tbody tr:nth-child(#{pos.to_i})") do
    fill_in("user[balance]", :with => value)
  end
end

When /^I click "([^"]*)" for the (\d+)(?:st|nd|rd|th) user$/ do |button,pos|
  within("tbody tr:nth-child(#{pos.to_i})") do
    click_button(button)
  end
end

Then /^I should see the following users:$/ do |expected_users_table|
  expected_users_table.diff!(tableish('tbody tr', 'td'))
end

Then /^the (\d+)(?:st|nd|rd|th) user balance should be "([^"]*)"$/ do |pos,value|
  within("tbody tr:nth-child(#{pos.to_i}):nth-child(1)") do |content|
  end
end

Then /^I should see "([^"]*)" for the (\d+)(?:st|nd|rd|th) user$/ do |value,pos|
  within("tbody tr:nth-child(#{pos.to_i})") do |content|
    content.should contain(value)
  end
end