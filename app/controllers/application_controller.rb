class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  # handle session cookies
  # (cookies for survey_id and user_id)
  include SessionsHelper

  private
  
      # Helped method for before_action Rails method for edit and update actions
      # if not signed in then flash a warning and redirect to sign in page
    def signed_in_user
      unless signed_in?
        store_URL_trying_to_be_accessed
        flash[:alert] = "Please sign in to access this page."
        redirect_to signin_path
      end
    end
    
end
