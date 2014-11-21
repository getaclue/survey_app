class SurveysController < ApplicationController
  # make sure user is signed in
  # user can only create a survey and destroy a survey
  before_action :signed_in_user, only: [:create, :destroy, :show, :update]
  
  # show contents of a survey
  def show
    @survey = current_user.surveys.find_by(id: params[:id])
    @questions = @survey.questions
    @newquestion = @survey.questions.build
    # @answers = @questions.answers
    # redirect to root if the survey doesn't exist
    if @survey.nil?
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
  
  # only actions allowed = create and destroy survey
  def create
    @survey = current_user.surveys.build(survey_parameters)
    if @survey.save
      # create an empty question automatically
      @question = @survey.questions.build(content: "Create your question...")
      @question.save
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
