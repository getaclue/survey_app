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
    render plain: params[:survey_item].inspect
    #####################
    # Extract question_id
    # Extract answer_id
    # Update
    # Redirect
    #####################
    # redirect_to qestion_vote_item_path(id, params[:survey_item][:answer_attributes][:answer_id])
    # redirect_to qestion_vote_item_path(question_id, id)
  end
end