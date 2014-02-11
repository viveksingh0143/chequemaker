class UsersController < ApplicationController
  layout 'noheaderfooter', only: [:new, :create]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(signup_user_params)
    if @user.save
      redirect_to root_url, success: "Thanks you for signing up!"
    else
      render "new"
    end
  end

  
  private
    def signup_user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
end
