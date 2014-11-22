class SurveyItemsController < ApplicationController
  before_filter :parent_survey
  
  def new
    # make a answer question only
    @newquestion = SurveyItem.new(content: "Testing the addition...", 
                                survey_id: "#{@survey.id}",
                                question:  false)
    @newquestion.toggle(:question)
    if @survey.questions << @newquestion
      flash[:success] = "Added a new question"
      redirect_to @survey
    end
  end
  
  def show
    @question = @survey.questions.find(params[:id])
    @newanswer = SurveyItem.new(content: ".... fill in ....")
    @answers = @question.answers
  end
  
  def create
    # create a new survey item
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
    def create_new_survey_item_parameters
      params.require(:survey_item).permit(:content)
    end
    
    def parent_survey
        @survey = current_user.surveys.find(params[:survey_id])
    end
end