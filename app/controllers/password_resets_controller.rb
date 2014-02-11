class PasswordResetsController < ApplicationController
  layout 'noheaderfooter', only: [:new, :create, :edit, :update]
  
  def new
    
  end
  
  def create
    user = User.find_by_email(password_reset_params[:email])
    user.send_password_reset if user
    redirect_to root_url, :notice => "Email sent with password reset instructions."
  end
  
  def edit
    @user = User.find_by_password_reset_token!(password_reset_params[:id])
  end
  
  def update
    @user = User.find_by_password_reset_token!(password_reset_params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "Password reset has expired."
    elsif @user.update_attributes(params[:user])
      redirect_to root_url, :notice => "Password has been reset!"
    else
      render :edit
    end
  end

  private
  
  def password_reset_params
    params.permit(:email, :remember_me)
  end
end
