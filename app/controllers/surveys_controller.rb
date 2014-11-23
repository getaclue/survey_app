class SurveysController < ApplicationController
  # make sure user is signed in
  # user can only create a survey and destroy a survey
  before_action :signed_in_user, only: [:create, :destroy, :show, :update]
  
  # show contents of a survey
  def show
    # gets the survey requested
    survey_requested = Survey.find_by(id: params[:id])
    @survey_owner = User.find_by(id: survey_requested.user)
    
    # checks that a survey is not assigned
    # if is not assigned... good. assign it to a session id
    # otherwise... clear the session id and assign a new id
    if !current_survey?
      add_current_survey(survey_requested)
    else
      remove_current_survey
      add_current_survey(survey_requested)
    end
    
    ##########################################################
    # make questions in the database false by default
    # Whenever we make a new question ==> question = true
    # Whenever we make a new answer ==> question = false
    ##########################################################
    @questions = current_survey.questions.where("question = ?", true)
    # makes a temp survey question
    @makenewquestion = SurveyItem.new
    # redirect to root if the survey doesn't exist
    if current_survey.nil?
      redirect_to root_url
    end
  end
  
  # update survey title
  def update
    @survey = current_user.surveys.find_by(id: params[:id])
    if @survey.update_attributes(survey_parameters)
      flash[:success] = "Title changed"
      redirect_to @survey
    else
      render 'show'
    end
  end
  
  # create a new survey
  def create
    @survey = current_user.surveys.build(survey_parameters)
    if @survey.save
      # create an empty question automatically
      # @question = @survey.questions.build(content: "Create your question...")
      # @question.save
      
      # survey has been successfully saved
      flash[:success] = "Survey Created!"
      redirect_to current_user
    else
      # change this later
      # need a root location
      render root
    end
  end
  
  def destroy
    current_user.surveys.find_by(id: params[:id]).destroy
    flash[:success] = "Survey deleted!"
    redirect_to current_user
  end
  
  private
  
    def survey_parameters
      params.require(:survey).permit(:title)
    end
    
end
