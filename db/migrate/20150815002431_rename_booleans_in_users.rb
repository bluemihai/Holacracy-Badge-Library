class RenameBooleansInUsers < ActiveRecord::Migration
  def change
    rename_column :users, :bootstrapper?, :bootstrapper
    rename_column :users, :librarian?, :librarian
    rename_column :users, :comp_admin?, :comp_admin
    rename_column :users, :active?, :active
  end
end
