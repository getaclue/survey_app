class SurveyItemsController < ApplicationController
  before_filter :parent_survey
  
  def new
    # make a new question only
    @question = @survey.questions.build(content: "Test", question: "true")
    if @question.save
      redirect_to @survey
    end
  end
  
  def show
    @question = @survey.questions.find(params[:id])
    @answers = @question.answers
  end
  
  def create
   @surveyitem = @survey.questions.build(content: "Blank test.", question: "true")
   if @surveyitem.save
     flash[:success] = "Added a question."
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
    
    def parent_survey
        @survey = current_user.surveys.find(params[:survey_id])
    end
end