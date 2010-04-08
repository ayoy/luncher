class MigrateVendorsToSeparateModel < ActiveRecord::Migration
  def self.up
    # rename :vendor to :vendor_name, otherwise it would come in conflict with
    # belongs_to :vendor newly defined in Lunch
    rename_column :lunches, :vendor, :vendor_name
    add_column :lunches, :vendor_id, :integer
    
    Lunch.reset_column_information
    Lunch.all.each do |lunch|
      lunch.vendor_id = Vendor.find_or_create_by_name(lunch.vendor_name).id
      lunch.save
    end
    
    remove_column :lunches, :vendor_name
  end

  def self.down
    add_column :lunches, :vendor_name, :string
    
    Lunch.reset_column_information
    Lunch.all.each do |lunch|
      lunch.vendor_name = Vendor.find(lunch.vendor_id).name
      lunch.save
    end
    
    remove_column :lunches, :vendor_id
    rename_column :lunches, :vendor_name, :vendor
  end
end
