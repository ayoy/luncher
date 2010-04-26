class OrdersController < ApplicationController
  before_filter :require_admin, :only => [:find_all_by_date, :find_by_month, :index]
  before_filter :require_user, :except => [:find_all_by_date, :find_by_month, :index]

  def index
    @date = Date.current
    @orders = Order.by_date(@date).ordered_by_vendor_name.group_by { |o| o.lunch.vendor.name }
    @orders.each {|vendor,order_list| order_list.sort! {|x,y| x.lunch.name <=> y.lunch.name}}
  end

  def monthly_report
    @date = Date.current
    @orders = Order.by_month(@date).ordered_by_vendor_name.group_by { |o| o.lunch.vendor.name }
  end

  def my
    @date = Date.current
    @orders = Order.by_user(current_user).by_date(@date).ordered_by_lunch_name
  end

  def find_by_month
    @date = Date.civil(params[:year].to_i,
                       params[:month].to_i,
                       1)
    @orders = Order.by_month(@date).ordered_by_vendor_name.group_by { |o| o.lunch.vendor.name }
    respond_to do |format|
      format.js
    end
  end

  def find_by_date
    @date = Date.civil(params[:year].to_i,
                       params[:month].to_i,
                       params[:day].to_i)
    @orders = Order.by_user(current_user).by_date(@date).ordered_by_lunch_name
    respond_to do |format|
      format.js
    end
  end

  def find_all_by_date
    @date = Date.civil(params[:year].to_i,
                       params[:month].to_i,
                       params[:day].to_i)
    @orders = Order.by_date(@date).ordered_by_vendor_name.group_by { |o| o.lunch.vendor.name }
    @orders.each {|vendor,order_list| order_list.sort! {|x,y| x.lunch.name <=> y.lunch.name}}
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @date = Date.current
    @order = Order.new
    flash[:notice] = "We're sorry, system is locked." if Setting.instance.system_locked
  end

  def create
    order = Order.new(params[:order])
    order.user_id = current_user.id
    order.total = order.lunch.price_for_user(order.user)
    if order.save
      flash[:notice] = "Lunch ordered!"
      redirect_to :action => :my
    else
      flash[:notice] = "We're sorry, system is locked."
      redirect_to :action => :new
    end
  end

  def destroy
    order = Order.find(params[:id])
    order.destroy
    flash[:notice] = "Order removed!"
    redirect_to :action => :my
  end

end
