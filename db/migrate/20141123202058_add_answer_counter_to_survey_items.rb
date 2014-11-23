class AddAnswerCounterToSurveyItems < ActiveRecord::Migration
  def change
    add_column :survey_items, :answer_counter, :Integer
    add_column :survey_items, :active, :boolean, default: false
  end
end
