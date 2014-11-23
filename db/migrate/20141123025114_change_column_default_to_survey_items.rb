class ChangeColumnDefaultToSurveyItems < ActiveRecord::Migration
  def change
    change_column_default :survey_items, :question, false
  end
end
