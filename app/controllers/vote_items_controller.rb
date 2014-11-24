class VoteItemsController < ApplicationController
  
  # activate one question for a survey
  def create
    # activate a questions
    question_to_activate = SurveyItem.find_by(id: params[:question_id])
    
    # check if question exists in survey
    if current_survey_have?(question_to_activate)
      if current_user?(current_survey.user)
        if question_to_activate.active?
          flash[:alert] = "Question is already active!"
        else
          question_to_activate.toggle(:active)
          question_to_activate.update_attributes(answer_counter: 0)
          question_to_activate.save
          flash[:success] = "#{question_to_activate.active}"
        end
      end
    end
    redirect_to survey_path(current_survey)
  end
  
  def edit
    render plain: params[:survey_item][:id].inspect
  end
  
  # process voting
  def update
  end
  
  # make question not active
  # activate one question for a survey
  def destroy
    # deactivate a questions
    question_to_destroy = SurveyItem.find_by(id: params[:question_id])
    # check if question exists in survey
    if current_survey_have?(question_to_destroy)
        if question_to_destroy.active?
          question_to_destroy.toggle(:active)
          question_to_destroy.save
          flash[:success] = "Question Deactivated."
        else
          flash[:alert] = "Question is not active."
        end
    end
    redirect_to survey_path(current_survey)
  end
  
  private
    def permitted_params
      params.require(:survey_item).permit(:question_id)
    end
end
