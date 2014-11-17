class AddAdminToUsers < ActiveRecord::Migration
  def change
    # added a default false attribute to make all users not admin
    add_column :users, :admin, :boolean, default: false
  end
end
