class CreateSurveyItems < ActiveRecord::Migration
  def change
    rename_table :questions, :survey_items
  end
end
