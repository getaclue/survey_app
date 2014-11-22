class SurveyItemsController < ApplicationController
  before_filter :parent_survey
  
  def new
    # make a new question only
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
    @answers = @question.answers
  end
  
  def create
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
    # def survey_items_parameters
    #   params.require(:survey).permit(:title, questions_attributes: [:id, :content])
    # end
    def create_new_survey_item_parameters
      params.require(:survey_item).permit(:content)
    end
    
    def parent_survey
        @survey = current_user.surveys.find(params[:survey_id])
    end
end