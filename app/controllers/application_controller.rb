class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authorize
  
  def email_regex
    return /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  end
  helper_method :email_regex
  
  private
  def current_user
    if session[:auth_token]
      @current_user ||= User.find_by_auth_token(session[:auth_token])
    elsif cookies[:auth_token]
      @current_user ||= User.find_by_auth_token!(cookies[:auth_token])
    end
  end
  helper_method :current_user

  def current_permission
    @current_permission ||= Permission.new(current_user)
  end

  def current_resource
    nil
  end

  def authorize
    if !current_permission.allow?(params[:controller], params[:action], current_resource)
      redirect_to root_url, alert: "You have no permission to access this page"
    end
  end
end
