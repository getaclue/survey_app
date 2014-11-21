class SurveyItem < ActiveRecord::Base
  ##############################################
  # Association to survey
  ##############################################
  belongs_to :survey
  
  ##############################################
  # Association to self?
  ##############################################
  has_many :answers, class_name: "SurveyItem",
                      foreign_key: "question_id"
  belongs_to :question, class_name: "SurveyItem"
end
