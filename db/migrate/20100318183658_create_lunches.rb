class CreateLunches < ActiveRecord::Migration
  def self.up
    create_table :lunches do |t|
      t.date :date
      t.string :vendor
      t.string :name
      t.text :description
      t.float :price, :default => 10
      t.boolean :refundable, :default => true

      t.timestamps
    end
  end

  def self.down
    drop_table :lunches
  end
end
