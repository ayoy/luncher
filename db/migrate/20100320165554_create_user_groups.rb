class CreateUserGroups < ActiveRecord::Migration
  def self.up
    create_table :user_groups do |t|
      t.string :name

      t.timestamps
    end

    create_table :user_groups_users, :id => false do |t|
      t.integer :user_group_id
      t.integer :user_id
    end

    # This will create the 'Administrator' user group and 
    # associate it to the user.
    Lockdown::System.make_user_administrator(User.find(1))
  end

  def self.down
		drop_table :user_groups_users
    drop_table :user_groups
  end
end
