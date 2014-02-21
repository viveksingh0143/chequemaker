class SessionsController < ApplicationController
  layout 'noheaderfooter', only: [:new, :create]

  def new
    if current_user
      redirect_to dashboard_path
    end
  end
  
  def index
    @banks = current_user.banks.enabled
    render layout: 'backend'
  end
  
  def create
    if  email_regex.match(signin_user_params[:login])
      user = User.find_by_email(signin_user_params[:login])
    else
      user = User.find_by_username(signin_user_params[:login])
    end

    if user && user.authenticate(signin_user_params[:password])
      if signin_user_params[:remember_me]
        cookies.permanent[:auth_token] = user.auth_token
      else
        session[:auth_token] = user.auth_token
#        cookies[:auth_token] = user.auth_token
      end
      flash[:success] = "Signin successfully!"
      redirect_to dashboard_path
    else
      flash[:error] = "Username/E-Mail or password is invalid."
      render :new
    end
  end

  def destroy
    session[:auth_token] = nil
    cookies.delete(:auth_token)
#   cookies[:auth_token] = user.auth_token
    flash[:info] = "Signout successfull!"
    redirect_to root_url
  end

  private
    def signin_user_params
      params.permit(:login, :password, :remember_me)
    end
end
