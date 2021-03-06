class SessionsController < ApplicationController
  def new
    
  end

  def create
    if ((params[:session][:email] == "admin") && (params[:session][:password] == "password"))
      p "--------------------"
      user = User.find_by(name: params[:session][:email])
      if user && user.authenticate(params[:session][:password])
        # login and redirect to user page
        flash[:success] = "Login successfully!"
        log_in user
        redirect_to allcourse_path
      else
        # create an error message
        flash.now[:danger] = 'Invalid email/password combination'
        render 'new'
      end
    else
      user = User.find_by(email: params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        # login and redirect to user page
        flash[:success] = "Login successfully!"
        log_in user
        redirect_to allcourse_path
      else
        # create an error message
        flash.now[:danger] = 'Invalid email/password combination'
        render 'new'
      end
    end
    
  end

  def destroy
    log_out
    flash[:success] = "You have logged out!"
    redirect_to root_url
  end
  
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
