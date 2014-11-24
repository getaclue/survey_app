class QuestionsController < ApplicationController
  
  include VoteItemsHelper
  
  #################################################################
  # Action used to display questions and answers
  # Get the question associated with the survey
  # Get all of the answers associated with a question
  # Create a answer in case the user wants to add more questions
  #################################################################
  def show
    @question = current_user.surveys.find(current_survey.id).questions.find(params[:id])
    @answers = @question.answers
    @newanswer = SurveyItem.new
  end
  
  #################################################################
  # Action used to create a single question associated with a survey
  # By default, toggle the question boolean (from false to true) to 
  # indicate that the SurveyItem object is, indeed, a question and 
  # not an answer
  #################################################################
  def create
    question = SurveyItem.new(create_new_survey_item_parameters)
    question.toggle(:question)
    if current_survey.questions << question
      flash[:success] = "Added a new question"
      redirect_to survey_survey_item_path(current_survey, question)
    end
  end
  
  #################################################################
  # Action used to undate the attributes of the question
  #################################################################
  def update
    # update a question content
    current_question = current_user.surveys.find(current_survey.id).questions.find(params[:id])
    if current_question.update_attributes(create_new_survey_item_parameters)
      # update was successful
      # flash message and redirect to show action
      flash[:success] = "Question updated"
      redirect_to survey_survey_item_path(current_survey, current_question)
    else
      # update was unsuccessful
      # show the show action again
      render 'show'
    end
  end
  
  def destroy
    # destroy a question
    question_id = params[:id]
    question_to_delete = SurveyItem.find_by(id: question_id)
    
    if current_survey_have?(question_to_delete)
        question_to_delete.destroy
        flash[:success] = "Question deleted!"
    end
    
    redirect_to survey_path(current_survey)
  end
  
  #################################################################
  # Helper methods
  #################################################################
  private
    #################################################################
    # method used to limit the parameters when modifying a question
    #################################################################
    def create_new_survey_item_parameters
      params.require(:survey_item).permit(:content)
    end
end
