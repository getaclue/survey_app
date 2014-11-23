class CreateVoteItems < ActiveRecord::Migration
  def change
    create_table :vote_items do |t|
      t.boolean :active, default: false
      t.integer :answer_count
      t.references :question, index: true
      t.references :answer, index: true

      t.timestamps null: false
    end
  end
end
