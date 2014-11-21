class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :question_id
      t.integer :answer_id

      t.timestamps null: false
    end
    add_index :relationships, :question_id
    add_index :relationships, :answer_id
    add_index :relationships, [:question_id, :answer_id], unique: true
  end
end
