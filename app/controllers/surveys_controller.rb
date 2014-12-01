class SurveysController < ApplicationController
  #################################################################
  # make sure user is signed in
  #################################################################
  before_action :signed_in_user, only: [:create, :destroy, :show, :update]
  
  #################################################################
  # Action to show contents of a requested survey
  #################################################################
  def show
    # gets the survey requested
    survey_requested = Survey.find_by(id: params[:id])
    
    #################################################################
    # Check if requested survey exists.
    # if the survey does not exist... redirect to root.
    #################################################################
    if !survey_requested
      flash[:alert] = "Sorry, that survey does not exist."
      redirect_to root_url
    else
      #################################################################
      # Survey exists!
      # Find the survey owner
      #################################################################
      @survey_owner = User.find_by(id: survey_requested.user)
      
      #################################################################
      # Checks if the survey has our session id
      #################################################################
      # if is not assigned... good. assign it to a session id
      # otherwise... clear the session id and assign a new id
      if !current_survey?
        add_current_survey(survey_requested)
      else
        remove_current_survey
        add_current_survey(survey_requested)
      end
      
      #################################################################
      # Find all of the created SurveyItems associated with the survey
      #################################################################
      @questions = current_survey.questions.where("question = ?", true)
      @questions_for_voting = current_survey.questions.where("question = ? AND active = ?", true, true)
      #################################################################
      # Create a temp SurveyItem so that a user can add a new question
      # Only if current user is the survey owner
      #################################################################
      if current_user?(@survey_owner)
        @makenewquestion = SurveyItem.new
      end
    end
  end
  
  #################################################################
  # Action to update survey title
  #################################################################
  def update
    #################################################################
    # Find the survey to update
    # Update survey parameters
    # Redirect or render to show action
    #################################################################
    @survey = current_user.surveys.find_by(id: params[:id])
    if @survey.update_attributes(survey_parameters)
      flash[:success] = "Survey title changed"
      redirect_to @survey
    else
      flash[:alert] = "Could not update survey attributes"
      render 'show'
    end
  end
  
  #################################################################
  # Action create/add a new survey
  #################################################################
  def create
    @survey = current_user.surveys.build(survey_parameters)
    if @survey.save
      #################################################################
      # survey has been successfully created and saved
      # redirect to survey view for futher survey actions
      #################################################################
      flash[:success] = "Survey Created!"
      redirect_to @survey
    else
      #################################################################
      # Something went wrong
      # Redirect to root
      #################################################################
      render "pages/index"
    end
  end
  
  #################################################################
  # Action to destroy/delete a survey
  #################################################################
  def destroy
    #################################################################
    # Only current_user that is the owner of the survey can destroy
    # Destroy survey
    # Redirect to user profile
    #################################################################
    current_user.surveys.find_by(id: params[:id]).destroy
    flash[:success] = "Survey deleted!"
    redirect_to current_user
  end
  
  #################################################################
  # Helper methods
  #################################################################
  private
    #################################################################
    # only allow the survey parameter to have a tittle attribute
    # nothing else
    #################################################################
    def survey_parameters
      params.require(:survey).permit(:title)
    end
    
end
