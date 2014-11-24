class SurveyItemsController < ApplicationController
  
  #################################################################
  # intermediary controller used to manipulate questions and answers
  # (and vote processing)
  #################################################################
  
  #################################################################
  # Action used to help remove multiple levels of nesting
  # simply redirects to the show action of the question controller
  #################################################################
  def show
    # simply redirect to show a question
    redirect_to question_path(params[:id])
  end
  
  def create
  end
  
  #################################################################
  # Action used to update the vote count on a question
  #################################################################
  def update
    #################################################################
    # User hit vote button even though no answers are present
    #################################################################
    if !params[:survey_item].present?
      flash[:alert] = "No answers present."
      redirect_to survey_path(current_survey)
    else
      answer_id = params[:survey_item][:id]
      question_id = params[:id]
      
      current_answer = current_survey.questions.find(question_id).answers.find(answer_id)
      current_answer.answer_counter
      flash[:success] = "Voted!"
  
      #########################################################
      # Note to self
      # ...can pass back values after a vote to disable a question
      # after a user has voted
      # redirect_to survey_path(current_survey.id, last_answered: question_id)
      #################################################################
      redirect_to survey_path(current_survey)
    end
  end
end