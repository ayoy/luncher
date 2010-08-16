# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all
  helper_method \
    :current_user_session,
    :current_user,
    :logged_in?,
    :current_user_is_admin?
  filter_parameter_logging :password, :password_confirmation
  
  protect_from_forgery

  protected

  def clear_authlogic_session
    sess = current_user_session
    sess.destroy if sess
  end

  private
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end
    
    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.record
    end
    
    def require_user
      unless current_user
        store_location
        flash[:notice] = t :must_be_logged_in
        redirect_to new_user_session_url
        return false
      end
    end

    def require_no_user
      if current_user
        store_location
        redirect_to account_url
        return false
      end
    end

    def require_admin
      unless current_user_is_admin?
        store_location
        flash[:notice] = "You don't have priviledges to access this page"
        redirect_to account_url
        return false
      end
    end
    
    def store_location
      session[:return_to] = request.request_uri
    end
    
    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end
end
