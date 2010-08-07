class AddAvailableToLunch < ActiveRecord::Migration
  def self.up
    add_column :lunches, :available, :boolean, :default => true
    add_index :lunches, :available
    add_index :lunches, [:date, :available]
  end

  def self.down
    remove_column :lunches, :available
    remove_index :lunches, [:date, :available]
  end
end
