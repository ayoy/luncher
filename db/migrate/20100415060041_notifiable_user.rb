class NotifiableUser < ActiveRecord::Migration
  def self.up
    add_column :users, :notifiable, :boolean, :default => true
    add_index :users, :notifiable
  end

  def self.down
    remove_column :users, :notifiable
  end
end
