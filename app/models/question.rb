class Question < ActiveRecord::Base
  belongs_to :survey
  
  # make sure a question is associated with a survey via
  # survey_id
  validates :survey_id, presence: true
  validates :content, presence: true
end
