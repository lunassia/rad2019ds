class UsersController < ApplicationController
  
  def index
    @users = User.all
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
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password)
    end
end
