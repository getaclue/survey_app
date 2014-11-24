class QuestionsController < ApplicationController
  # dont forget about the survey_id cookie!!
  # remove it before final version
  
  include VoteItemsHelper

  def show
    # show a question and its answers
    @question = current_user.surveys.find(current_survey.id).questions.find(params[:id])
    @answers = @question.answers
    @newanswer = SurveyItem.new
  end
  
  def create
    # create a new question ONLY
    question = SurveyItem.new(create_new_survey_item_parameters)
    question.toggle(:question)
    if current_survey.questions << question
      flash[:success] = "Added a new question"
      redirect_to survey_survey_item_path(current_survey, question)
    end
  end
  
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
  
  private
    # used to create an answer and a quesiton
    def create_new_survey_item_parameters
      params.require(:survey_item).permit(:content)
    end
end
