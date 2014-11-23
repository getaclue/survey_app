class AnswersController < ApplicationController
  before_action :parent_question
  
  # dont forget about the survey_id cookie!!
  # remove it before final version
  
  # create a new answer (SurveyItem)
  # need survey_id
  # need question_id
  def create
    # make an answer SurveyItem only
    
    # case 1: No answers present
    # does the question have any answers?
    if !parent_answers?
      new_answer = parent_question.answers.create(create_new_survey_item_parameters)
      new_answer.update_attributes(survey_id: current_survey.id)
      flash[:success] = "Added a new question"
      redirect_to question_path(parent_question)
    else
      # case 2: answers present
      new_answer = SurveyItem.new(create_new_survey_item_parameters)
      new_answer.update_attributes(survey_id: current_survey.id)
      if parent_question.answers << new_answer
        flash[:success] = "Added a new question"
        redirect_to question_path(parent_question)
      end
    end
  end
  
  # update a given answer
  # 1 at a time
  def update
    answer_to_update = current_user.surveys.find(current_survey.id).questions.find(params[:question_id]).answers.find(params[:id])
    answer_to_update.update_attributes(create_new_survey_item_parameters)
    flash[:success] = "Edited an answer"
    redirect_to question_path(parent_question)
  end
  
  # delete a given answer
  # 1 at a time
  def destroy
    answer_to_delete = current_user.surveys.find(current_survey.id).questions.find(params[:question_id]).answers.find(params[:id])
    answer_to_delete.destroy
    flash[:success] = "Deleted an answer"
    redirect_to question_path(parent_question)
  end
  
  private
    # used to create an answer and a quesiton
    def create_new_survey_item_parameters
      params.require(:survey_item).permit(:content)
    end
    
    # get the question associated with the answer
    def parent_question
      @question = current_survey.questions.find(params[:question_id])
    end
    
    def parent_answers?
      parent_question.answers.any?
    end
      
end
