class SurveyItem < ActiveRecord::Base
  # belongs to a survey
  belongs_to :survey
  
  # validates presence of survey_id and content
  validates :survey_id, presence: true
  validates :content, presence: true
end
