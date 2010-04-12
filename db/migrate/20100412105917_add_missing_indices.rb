class AddMissingIndices < ActiveRecord::Migration
  def self.up
    add_index :users, :email
    add_index :users, :last_name

    add_index :lunches, :date
    add_index :lunches, :name
    add_index :lunches, :price
    add_index :lunches, :refundable

    add_index :orders, :lunch_id
  end

  def self.down
    remove_index :users, :email
    remove_index :users, :last_name

    remove_index :lunches, :date
    remove_index :lunches, :name
    remove_index :lunches, :price
    remove_index :lunches, :refundable

    remove_index :orders, :lunch_id
  end
end
