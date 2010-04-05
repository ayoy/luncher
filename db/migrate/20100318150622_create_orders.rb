class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.integer :lunch_id
      t.integer :user_id
      t.float :total, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end
