###
### helpers
###

def user(username)
  if User.first(:conditions => {:login => username}, :select => :id).nil?
    user ||= Factory :user, :login => username
  end
end

def login(username)
  user username
  visit login_path
  fill_in "Login", :with => username
  fill_in "Password", :with => "password"
  click_button "Login"
  response.should contain("Login successful!")
  response.should contain("Log Out")
end

###
### steps
###

Given /^there is a user called "([^"]*)"$/ do |username|
  user username
end

Given /^there is an admin user called "([^"]*)"$/ do |username|
  user username
  Lockdown::System.make_user_administrator(User.first(:conditions => {:login => username}))
end

Given /^I log in as user "(.+)"$/ do |username|
  login username
end

