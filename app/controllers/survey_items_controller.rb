class SurveyItemsController < ApplicationController
  before_filter :parent_survey
  
  def new
    # make an answer SurveyItem only
    @newanswer = SurveyItem.new(create_new_survey_item_parameters)
    if parent_question.answers << @newanswer
      flash[:success] = "Added a new question"
      redirect_to survey_question_path(parent_survey.id, parent_question.id)
    end
  end
  
  def show
    @question = @survey.questions.find(params[:id])
    @answers = @question.answers
    @newanswer = SurveyItem.new
  end
  
  def create
    # create a new question SurveyItem item
    @newquestion = SurveyItem.new(create_new_survey_item_parameters)
    @newquestion.toggle(:question)
    if @survey.questions << @newquestion
      flash[:success] = "Added a new question"
      redirect_to @survey
    end
  end
  
  def update
      @surveyitem = @survey.questions.find(params[:id])
  end
  
  def destroy
  end
  
  private
    # used to create an answer and a quesiton
    def create_new_survey_item_parameters
      params.require(:survey_item).permit(:content)
    end
  
    # used to create a new question
    def parent_survey
        @survey = current_user.surveys.find(params[:survey_id])
    end
    
    # used to create the new answer
    def parent_question
      @question = @survey.questions.find(params[:question_id])
    end
end