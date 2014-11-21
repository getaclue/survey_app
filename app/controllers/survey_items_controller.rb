class SurveyItemsController < ApplicationController
  def create
   #@survey_item = 
   @survey = current_user.surveys.find(params[:id])
   @surveyitem = @survey.questions.build(content: "Something goes here...")
   if @surveyitem.save
     flash[:success] = "Added a question."
     redirect_to @survey
   end
  end
  
  private
    def survey_items_parameters
      params.require(:survey).permit(:title, questions_attributes: [:id, :content])
    end
end
