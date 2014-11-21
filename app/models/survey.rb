class Survey < ActiveRecord::Base
  # association to user
  belongs_to :user
  
  # association to survey_items
  # delete survey_items if survey is deleted
  has_many :questions, class_name: "SurveyItem", dependent: :destroy
  
  # validates presence of user_id and title
  validates :user_id, presence: true
  validates :title, presence: true
end
