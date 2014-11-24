class SurveyItem < ActiveRecord::Base
  ##############################################
  # Association to survey
  ##############################################
  belongs_to :survey
  # validation
  validates :survey_id, presence: true
  validates :content, presence: true
  
  ##############################################
  # Association to self?
  ##############################################
  has_many :answers, class_name: "SurveyItem",
                      foreign_key: "question_id",
                      dependent: :destroy
  accepts_nested_attributes_for :answers
  
  belongs_to :question, class_name: "SurveyItem"
  
  # can activate the voting several times
  has_many :vote_items, dependent: :destroy
end