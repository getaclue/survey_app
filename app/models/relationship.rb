class Relationship < ActiveRecord::Base
  belongs_to :question, class_name: "SurveyItem"
  belongs_to :answer, class_name: "SurveyItem"
end
