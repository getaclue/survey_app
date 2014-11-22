class AddQuestionToSurveyItems < ActiveRecord::Migration
  def change
    add_column :survey_items, :question, :boolean
    add_index :survey_items, :question
  end
end
