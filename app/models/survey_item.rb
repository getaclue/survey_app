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
  belongs_to :question, class_name: "SurveyItem"
  
  ##############################################
  # Association to self? Attempt #2
  ##############################################
  # has_one :question_relationships, class_name: "Relationship",
  #                                   foreign_key: "question_id",
  #                                   dependent: :destroy
  
  # has_many :answer_relationships, class_name: "Relationship",
  #                                   foreign_key: "answer_id",
  #                                   dependent: :destroy
  
  # has_many :questions, through: :question_relationships
  # has_many :answers, through: :answer_relationships
  
end
