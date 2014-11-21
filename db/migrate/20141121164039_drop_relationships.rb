class DropRelationships < ActiveRecord::Migration
  def change
    drop_table :relationships
    #####################################################
    # Trying initial self-reference based on rails manual
    # removing attempt #2
    #####################################################
  end
end
