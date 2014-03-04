class UsersController < ApplicationController
  layout 'noheaderfooter', only: [:new, :create]
  
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  
  # GET /users
  # GET /users.json
  def index
    @users = User.paginate(:per_page => 20, :page => params[:page])
    render layout: "backend"
  end
  
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
  
  # GET /users/1/edit
  def edit
    if !current_user.admin && !is_profile
      flash[:alert] = 'You can only update your profile'
      redirect_to root_path
    else
      render layout: "backend"
    end
  end
  
  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if current_user.admin
        if @user.update(admin_user_params)
          format.html { redirect_to users_url, notice: 'user was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render layout: "backend", action: 'edit' }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      else
        if is_profile && @user.update(signup_user_params)
          format.html { redirect_to root_path, notice: 'user was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render layout: "backend", action: 'edit' }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  end
  
  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  
  private
    def is_profile
      (current_user.id==@user.id)
    end
    
    def set_user
      @user = User.find(params[:id])
    end
    
    def admin_user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation, :admin)
    end
    
    def signup_user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
end
