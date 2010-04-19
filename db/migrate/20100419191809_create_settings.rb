class CreateSettings < ActiveRecord::Migration
  def self.up
    create_table :settings do |t|
      t.boolean :automatic_locking_enabled
      t.time :automatic_locking_time
      t.boolean :lunch_refunding
      t.integer :refunded_lunches_per_day
      t.float :money_refunded_per_lunch

      t.timestamps
    end
  end

  def self.down
    drop_table :settings
  end
end
