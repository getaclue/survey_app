class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.text :title
      t.references :user, index: true

      t.timestamps null: false
    end
      # associates a user_id with each survey item
      add_index :surveys, [:user_id, :created_at]
  end
end
