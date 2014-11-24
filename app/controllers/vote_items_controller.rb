class VoteItemsController < ApplicationController
  
  # activate one question for a survey
  def create
    #######################################################
    # Attempt #1
    #######################################################
    # make_question_collection
    # add_questions(@questions)
    
    # redirect_to current_survey_path
    #######################################################
    # Attempt #2
    #######################################################
    # activate_entry = VoteItem.new
    # activate_entry.toggle(:activate)
    # activate_entry.update_attributes(question_id: params[:question_id])
    #######################################################
    # Attempt #3
    #######################################################
    @question_to_activate = current_survey.questions.find_by(params[:id])
    if !@question_to_activate.active?
      @question_to_activate.toggle(:active)
      @question_to_activate.update_attributes(answer_counter: "0")
      @question_to_activate.save
      flash[:success] = "#{@question_to_activate.active}"
      redirect_to survey_path(current_survey)
    else
      flash[:alert] = "Question is already active!"
      redirect_to survey_path(current_survey)
    end
  end
  
  def edit
    render plain: params[:survey_item][:id].inspect
  end
  
  # process voting
  def update
    @question = current_survey.questions.find_by(id: params[:question_id])

    if @question.active?
      # @answer_to_update = SurveyItem.find(question_id: params[:question_id]).find_by(id: params[:survey_item][:question_id])
      # @counter = @answer_to_update.answer_counter
      # @counter = @counter + 1
      # @answer_to_update.update_attributes(answer_counter: @counter)
      # @answer_to_update.save
      flash[:success] = "Voted! #{@counter}"
      redirect_to survey_path(current_survey)
    else
      flash[:success] = "Nope!"
      redirect_to survey_path(current_survey)
    end
    
  end
  
  private
    def permitted_params
      params.require(:survey_item).permit(:question_id)
    end
end
