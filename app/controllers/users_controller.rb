class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_admin, :only => [:index]
  before_filter :require_user, :only => [:show, :edit, :update]
  before_filter :fetch_user, :only => [:show, :edit, :update]

  def fetch_user
    if params[:id]
      if current_user_is_admin? || params[:id].to_i == current_user.id
        @user = User.find(params[:id])
      else
        flash[:notice] = "You don't have priviledges to access this page"
        redirect_to account_url
      end
    else
      @user = current_user # makes our views "cleaner" and more consistent
    end
  end

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Account registered!"
      add_lockdown_session_values(@user)
      redirect_to account_url
    else
      render :action => :new
    end
  end
  
  def show
  end

  def edit
  end
  
  def update
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      respond_to do |format|
        format.html { redirect_to account_url }
        format.js
      end
    else
      render :action => :edit
    end
  end

  def destroy
    if current_user_is_admin?
      user = User.find(params[:id])
      user.destroy
      flash[:notice] = "User #{user.login} deleted!"
    end
    redirect_to root_path
  end

end
