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
      conditional_redirect user
    else
      # unsuccessful session
      # either user was not found or password was not correct
      # redirect to signin page
      flash.now[:alert] = 'Invalid email and/or password'
      render 'new'
    end
  end
  
  # Destroys the current login session
  def destroy
    # let the user signout only if the user is signed in
    sign_out if signed_in?
    redirect_to root_url
  end
  
  # Redirect to a default location OR
  # Redirect to URL trying to be accessed
  def conditional_redirect(default)
    redirect_to(session[:URL_trying_to_be_accessed] || default)
    session.delete(:URL_trying_to_be_accessed)
  end
  
  # Store URL trying to be accessed
  def store_URL_trying_to_be_accessed
    session[:URL_trying_to_be_accessed] = request.url if request.get?
  end
  
end
