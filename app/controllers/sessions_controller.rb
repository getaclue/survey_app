class SessionsController < ApplicationController
  
  # Handles initial login
  def new
  end
  
  # Creates a new login sessions
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    user_auth = user.authenticate(params[:session][:password])
    if user && user_auth
      # awesome
    else
      render 'new'
    end
  end
  
  # Destroys the current login session
  def destroy
  end
end
