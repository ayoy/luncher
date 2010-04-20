User.create \
          :login => 'root',
          :email => 'lunch_admin@ayoy.net',
          :first_name => 'root',
          :last_name => 'root',
          :password => 'rootme',
          :password_confirmation => 'rootme'

# This will create the 'Administrator' user group and 
# associate it to the user.
Lockdown::System.make_user_administrator(User.find(1))

Setting.instance.update_attributes \
          :system_locked => false,
          :automatic_locking => false,
          :automatic_locking_time => Time.parse("10:00"),
          :lunch_refunding => false,
          :refunded_lunches_per_day => 0,
          :money_refunded_per_lunch => 0