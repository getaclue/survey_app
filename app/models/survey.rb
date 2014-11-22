class Survey < ActiveRecord::Base
  # association to user
  belongs_to :user
  
  # association to survey_items
  # delete survey_items if survey is deleted
  has_many :questions, -> { includes :answers },
                      class_name: "SurveyItem",
                      dependent: :destroy
  accepts_nested_attributes_for :questions
  
  # validates presence of user_id and title
  validates :user_id, presence: true
  validates :title, presence: true
end
