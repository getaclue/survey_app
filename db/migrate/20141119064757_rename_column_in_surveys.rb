class RenameColumnInSurveys < ActiveRecord::Migration
  def change
    rename_column :surveys, :content, :title
  end
end
