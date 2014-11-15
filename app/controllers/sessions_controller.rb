class SessionsController < ApplicationController
  
  # Handles initial login
  def new
  end
  
  # Creates a new login sessions
  def create
    user = User.find_by(email: params[:session][:email].downcase)

    if user && user.authenticate(params[:session][:password])
      # successful
      sign_in user
      redirect_to user
    else
      # unsuccessful
      render 'new'
    end
  end
  
  # Destroys the current login session
  def destroy
  end
end
