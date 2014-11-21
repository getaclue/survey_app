class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :content
      t.references :survey, index: true

      t.timestamps null: false
    end
      # associates a survey_id with each survey item
      add_index :questions, [:survey_id, :created_at]
  end
end
