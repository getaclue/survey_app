class QuestionsController < ApplicationController
  # dont forget about the survey_id cookie!!
  # remove it before final version

  def show
    # show a question and its answers
    @question = current_survey.questions.find(params[:id])
    @answers = @question.answers
    @newanswer = SurveyItem.new
  end
  
  def create
    # create a new question ONLY
    @newquestion = SurveyItem.new(create_new_survey_item_parameters)
    @newquestion.toggle(:question)
    if current_survey.questions << @newquestion
      flash[:success] = "Added a new question"
      redirect_to current_survey
    end
  end
  
  def update
    # update a question content
    @surveyitem = current_survey.questions.find(params[:id])
  end
  
  def destroy
    # destroy a question
  end
  
  private
    # used to create an answer and a quesiton
    def create_new_survey_item_parameters
      params.require(:survey_item).permit(:content)
    end
end
