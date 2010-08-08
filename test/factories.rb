Factory.define :lunch do |lunch|
  lunch.date    Date.current
  lunch.sequence(:name) { |n| "name #{n}" }
  lunch.sequence(:description) { |n| "description #{n}" }
  lunch.association(:vendor)
end

Factory.define :vendor do |vendor|
  vendor.sequence(:name) { |n| "name #{n}" }
  vendor.notification_sent_on '2010-01-01'
end

Factory.define :user do |user|
  user.sequence(:login) { |n| "login #{n}" }
  user.sequence(:email) { |n| "email#{n}@luncher.pl" }
  user.sequence(:first_name) { |n| "name #{n}" }
  user.sequence(:last_name) { |n| "last name #{n}" }
  user.password "password"
  user.password_confirmation "password" 
end

Factory.define :order do |order|
  order.association(:lunch)
  order.association(:user)
end
