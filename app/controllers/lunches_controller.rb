class LunchesController < ApplicationController

  def index
    @date = Date.current
    @lunches = Lunch.by_date(@date).ordered_by_name
  end

  def find_by_date
    @date = Date.civil(params[:year].to_i,
                       params[:month].to_i,
                       params[:day].to_i)
    @lunches = Lunch.by_date(@date).ordered_by_name
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show_by_date
    @date = Date.civil(params[:year].to_i,
                       params[:month].to_i,
                       params[:day].to_i)
    @lunches = Lunch.by_date(@date).ordered_by_name
    respond_to do |format|
      format.js
    end
  end

  def new
    @lunch = Lunch.new(:name => Lunch.first_available_name_for_date(Date.current))
  end

  def edit
    @lunch = Lunch.find(params[:id])
  end

  def create
#    params[:lunch][:vendor_id] = Vendor.find_by_name(params[:lunch][:vendor]).id
#    params[:lunch].delete(:vendor)
    @lunch = Lunch.new(params[:lunch])
    if @lunch.save
      flash[:notice] = "Lunch added!"
      redirect_back_or_default lunches_url
    else
      render :action => :new
    end
  end

  def update
#    params[:lunch][:vendor_id] = Vendor.find_by_name(params[:lunch][:vendor]).id
#    params[:lunch].delete(:vendor)
    @lunch = Lunch.find(params[:id])
    if @lunch.update_attributes(params[:lunch])
      flash[:notice] = "Lunch info updated!"
      redirect_to lunches_url
    else
      render :action => :index
    end
  end

  def destroy
    lunch = Lunch.find(params[:id])
    if lunch.removable?
      flash[:notice] = "Lunch removed!" if lunch.destroy
    elsif lunch.has_pending_orders?
      flash[:notice] = "There are pending orders for this lunch, it can't be removed"
    else
      flash[:notice] = "Lunch removed!" if lunch.update_attribute(:available, false)
    end
    redirect_to :action => :index
  end
end
