class UsersController < ApplicationController
  before_action :set_user, only: [:destroy]
  before_action :logged_in_user, only: [:edit, :update, :show, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  
  def edit
    @user = User.find(params[:id])
  end

  
  def show
    @users = User.all
    @user = User.find(params[:id])
    @courses = @user.courses
  end
  
  def new
     @user = User.new
  end
  
  def create
      @user = User.new(user_params)
      if @user.save
        # sign up successfully
        log_in @user
        flash[:success] = "Welcome to Your Course App!"
        redirect_to @user
      else
        render 'new'
      end
    # end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # update successfully
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end  
  
  def destroy
    if ((@user.isadmin == 0) && (current_user.isadmin == 1))
      @user.destroy
      flash[:success] = 'Coordinator deleted successfully!'
      redirect_back(fallback_location: root_path)
    elsif ((@user.isadmin == 1) && (current_user.isadmin == 1))
      flash[:danger] = "Admin cannot be deleted!"
      redirect_back(fallback_location: root_path)
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password)
    end
    
    def set_user
      @user = User.find(params[:id])
    end
    
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless (current_user?(@user)) ||(current_user.isadmin == 1)
    end    
    
end
