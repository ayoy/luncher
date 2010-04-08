class CreateVendors < ActiveRecord::Migration
  def self.up
    create_table :vendors do |t|
      t.string :name

      t.timestamps
    end
    
    add_index :vendors, :name
  end

  def self.down
    drop_table :vendors
  end
end
