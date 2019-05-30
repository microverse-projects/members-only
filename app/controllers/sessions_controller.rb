class SessionsController < ApplicationController
  
  def new
    render 'new'
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
      log_in user
      # remember user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to root_url
    else
      # Create an error message.
      flash.now[:danger] = 'Invalid email/password combination'
      redirect_to signup_url
    end
  end

  def delete
    sign_out if logged_in?
    redirect_to login_url
  end

end
