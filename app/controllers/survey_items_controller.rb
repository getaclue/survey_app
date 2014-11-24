class SurveyItemsController < ApplicationController
  
  # show the specific survey item associated with a survey
  # must show the question
  # must show the answers
  
  def show
    # simply redirect to show a question
    redirect_to question_path(params[:id])
  end
  
  def create
  end
  
  def update
    # vote for a question
    if !params[:survey_item].present?
      flash[:alert] = "No answers present."
      redirect_to survey_path(current_survey)
    else
      answer_id = params[:survey_item][:id]
      question_id = params[:id]
      
      current_answer = current_survey.questions.find(question_id).answers.find(answer_id)
      current_answer.answer_counter
      flash[:success] = "Voted!"
  
      # render plain: params[:id]
      # answer_id = params[:survey_item][:id]
      # redirect_to question_vote_items_path(question_id: "#{question_id}", answer_id: "#{answer_id}"), action: :create
      # redirect_to question_vote_item_path(question_id, answer_id)
      
      #########################################################
      # Nifty... can pass back values (can disable submissions)
      #########################################################
      # redirect_to survey_path(current_survey.id, last_answered: question_id)
      redirect_to survey_path(current_survey)
    end
  end
end