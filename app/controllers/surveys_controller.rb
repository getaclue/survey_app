class SurveysController < ApplicationController
  # make sure user is signed in
  # user can only create a survey and destroy a survey
  before_action :signed_in_user, only: [:create, :destroy]
  
  # only actions allowed = create and destroy survey
  def create
    @survey = current_user.survey.build(survey_parameters)
    if @survey.save
      # survey has been successfully saved
      flash[:sucess] = "Survey Created!"
      redirect_to root_url
    else
      # change this later
      # need a root location
      render root
    end
  end
  
  def destroy
  end
  
  private
  
    def survey_parameters
      params.require(:survey).permit(:title)
    end
  
end
