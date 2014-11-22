class DroppingSurveyItems < ActiveRecord::Migration
  def change
    drop_table :survey_items
  end
end
