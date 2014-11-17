class SessionsController < ApplicationController
  
  # Handles initial signin
  def new
  end
  
  # Creates a new login sessions
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # successful session
      # reset any previous session
      reset_session
      
      # user was (1) found and
      # (2) user password was correct
      # redirect to user.show
      sign_in user
      redirect_to user
    else
      # unsuccessful session
      # either user was not found or password was not correct
      # redirect to signin page
      flash.now[:danger] = 'Invalid email and/or password'
      render 'new'
    end
  end
  
  # Destroys the current login session
  def destroy
    sign_out
    redirect_to root_url
  end
end
