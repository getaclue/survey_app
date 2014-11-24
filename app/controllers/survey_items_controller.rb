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
end