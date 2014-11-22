class ReCreatingSurveyItemsTable < ActiveRecord::Migration
  def change
    create_table :survey_items do |t|
      t.text :content
      t.references :survey, index: true
      t.references :question, index: true

      t.timestamps null: false
    end
  end
end
