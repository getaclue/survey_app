class PagesController < ApplicationController
  #################################################################
  # Responsible for showing the main page of the application
  #################################################################
  def index
    #################################################################
    # Create an instance of a survey only if the user is signed in
    #################################################################
    @survey = current_user.surveys.build if signed_in?
  end
end
