class SettingsController < ApplicationController
  before_filter :require_admin

  # GET /settings/1/edit
  def edit
    @setting = Setting.instance
  end

  # PUT /settings/1
  # PUT /settings/1.xml
  def update
    @setting = Setting.instance

    respond_to do |format|
      if @setting.update_attributes(params[:setting])
        flash[:notice] = 'Settings saved!'
        format.html { render :action => "edit" }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @setting.errors, :status => :unprocessable_entity }
      end
    end
  end

  def unlock_system
    Setting.toggle_system_locked(false)
    flash[:notice] = 'System unlocked.'
    redirect_to :action => :edit
  end

  def lock_system
    Setting.toggle_system_locked(true)
    flash[:notice] = 'System locked.'
    redirect_to :action => :edit
  end
end
