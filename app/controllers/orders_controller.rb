class OrdersController < ApplicationController
  before_filter :require_admin, :only => [:find_all_by_date, :today]
  before_filter :require_user, :except => [:find_all_by_date, :today]

  def index
    @date = Date.current
    @orders = Order.by_user(current_user).by_date(@date).ordered_by_lunch_name
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
    @orders = Order.by_date(@date).ordered_by_lunch_name.group_by { |o| o.lunch.name }
  end

  def today
    redirect_to :action => :find_all_by_date,
      :year => Date.current.year,
      :month => Date.current.month,
      :day => Date.current.day
  end

  def new
    @date = Date.current
    @order = Order.new
  end

  def create
    order = Order.new(params[:order])
    order.user_id = current_user.id
    order.total = order.lunch.price_for_user(order.user)
    flash[:notice] = "Lunch ordered!" if order.save
    redirect_to :action => :index
  end

  def destroy
    order = Order.find(params[:id])
    order.destroy
    flash[:notice] = "Order removed!"
    redirect_to :action => :index
  end

end
