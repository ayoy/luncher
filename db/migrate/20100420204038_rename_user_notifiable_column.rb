class RenameUserNotifiableColumn < ActiveRecord::Migration
  
  def self.up
    rename_column :users, :notifiable, :email_notification_enabled
  end

  def self.down
    rename_column :users, :email_notification_enabled, :notifiable 
  end

end
