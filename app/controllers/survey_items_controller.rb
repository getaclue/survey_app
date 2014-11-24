class SurveyItemsController < ApplicationController
  
  # show the specific survey item associated with a survey
  # must show the question
  # must show the answers
  
  def show
    redirect_to question_path(params[:id])
  end
  
  def create
    # activate a question
    # redirect_to
  end
  
  def update
    answer_id = params[:survey_item][:id]
    question_id = params[:id]
    
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