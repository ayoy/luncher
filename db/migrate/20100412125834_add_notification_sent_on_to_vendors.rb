class AddNotificationSentOnToVendors < ActiveRecord::Migration
  def self.up
    add_column :vendors, :notification_sent_on, :date
  end

  def self.down
    remove_column :vendors, :notification_sent_on, :date
  end
end
