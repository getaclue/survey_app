class VoteItemsController < ApplicationController
  
  #################################################################
  # intermediary controller that is used to control activation
  # and deactivation of a question in a survey
  #################################################################
  
  #################################################################
  # Create action is used to activate one question in a survey
  #################################################################
  def create
    #################################################################
    # Find the question that is trying to be activated
    #################################################################
    question_to_activate = SurveyItem.find_by(id: params[:question_id])
    
    #################################################################
    # check if question exists in survey
    #################################################################
    if current_survey_have?(question_to_activate)
      #################################################################
      # check if current_user is the owner of the survey where the question
      # is trying to be activated
      #################################################################
      if current_user?(current_survey.user)
        if question_to_activate.active?
          #################################################################
          # No need to activate question b/c it is already active
          #################################################################
          flash[:alert] = "Question is already active!"
        else
          #################################################################
          # Activate question by toggling active boolean from false to true
          # and set the counter for the question to zero
          #################################################################
          question_to_activate.toggle(:active)
          question_to_activate.update_attributes(answer_counter: 0)
          question_to_activate.save
          flash[:success] = "Question is now active. Users can now view the question."
        end
      end
    end
    redirect_to survey_path(current_survey)
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
