class SessionsController < ApplicationController
  
  def new
    render 'new'
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
      log_in user
      redirect_to root_url
    else
      # Create an error message.
      flash.now[:danger] = 'Invalid email/password combination'
      redirect_to signup_url
    end
  end

end
