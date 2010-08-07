class AddAvailableToVendor < ActiveRecord::Migration
  def self.up
    add_column :vendors, :available, :boolean, :default => true
    add_index :vendors, :available
  end

  def self.down
    remove_column :vendors, :available
  end
end
