class VendorsController < ApplicationController
  before_filter :require_admin

  def new
    @vendor = Vendor.new
  end

  def edit
    @vendor = Vendor.find(params[:id])
  end

  def index
    @vendors = Vendor.all_available
  end

  def notify_users
    vendor = Vendor.find(params[:id])
    Notifier.deliver_lunch_notification(vendor, vendor.notifiable_users_for_date(Date.current))
    flash[:notice] = "E-mail notification sent for #{vendor}"
    vendor.update_attribute(:notification_sent_on, Date.current)
    redirect_to vendors_url
  end
  
  def mark_orders_complete
    vendor = Vendor.find(params[:id])
    vendor.orders.each do |order|
      order.mark_as_complete
    end
    flash[:notice] = "Orders from #{vendor} marked as complete"
    redirect_to vendors_url
  end
  
  def mark_orders_new
    vendor = Vendor.find(params[:id])
    vendor.orders.each do |order|
      order.mark_as_new
    end
    flash[:notice] = "Orders from #{vendor} marked as new"
    redirect_to vendors_url
  end

  def create
    vendor = Vendor.new(params[:vendor])
    flash[:notice] = "Vendor added!" if vendor.save
    redirect_to vendors_url 
  end

  def update
    vendor = Vendor.find(params[:id])
    flash[:notice] = "Vendor info updated!" if vendor.update_attributes(params[:vendor])
    redirect_to vendors_url 
  end

  def destroy
    vendor = Vendor.find(params[:id])
    if vendor.removable?
      flash[:notice] = "Vendor removed!" if vendor.destroy
    else
      flash[:notice] = "Vendor removed!" if vendor.update_attribute(:available, false)
    end
    redirect_to vendors_url 
  end
end
