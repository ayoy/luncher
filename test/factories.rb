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
  #user.persistence_token "6cde0674657a8a313ce952df979de2830309aa4c11ca65805dd00bfdc65dbcc2f5e36718660a1d2e68c1a08c276d996763985d2f06fd3d076eb7bc4d97b1e317"
  #user.perishable_token "6cde0674657a8a313ce952df979de2830309aa4c11ca65805dd00bfdc65dbcc2f5e36718660a1d2e68c1a08c276d996763985d2f06fd3d076eb7bc4d97b1e317"
  #user.password_salt Authlogic::Random.hex_token
  #user.crypted_password Authlogic::CryptedProviders::Sha512.encrypt(user.password + user.password_salt)
  #user.created_at Date.current
  #user.updated_at Date.current
  #user.last_request_at Date.current
  #user.last_login_at Date.current
end

Factory.define :order do |order|
  order.association(:lunch)
  order.association(:user)
end
