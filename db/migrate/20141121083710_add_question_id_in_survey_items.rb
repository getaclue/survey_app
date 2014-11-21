class AddQuestionIdInSurveyItems < ActiveRecord::Migration
  def change
    add_column :survey_items, :question_id, :integer
  end
end
