class VoteItem < ActiveRecord::Base
  belongs_to :question, class_name: "SurveyItem", dependent: :destroy
  belongs_to :answer, class_name: "SurveyItem", dependnet: :destroy
end
