class MigrateVendorsToSeparateModel < ActiveRecord::Migration
  def self.up
    add_column :lunches, :vendor_id, :integer
    
    Lunch.reset_column_information
    Lunch.all.each do |lunch|
      lunch.vendor_id = Vendor.find_or_create_by_name(lunch.read_attribute(:vendor)).id
      lunch.save
    end
    
    remove_column :lunches, :vendor
  end

  def self.down
    add_column :lunches, :vendor, :string
    
    Lunch.reset_column_information
    Lunch.all.each do |lunch|
      lunch.write_attribute(:vendor, Vendor.find(lunch.vendor_id).name)
      lunch.save
    end
    
    remove_column :lunches, :vendor_id
  end
end
