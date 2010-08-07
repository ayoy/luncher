class AddCompleteToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :complete, :boolean, :default => :false
    add_index :orders, :complete
  end

  def self.down
    remove_column :orders, :complete
  end
end
