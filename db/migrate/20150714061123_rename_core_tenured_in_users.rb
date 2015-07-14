class RenameCoreTenuredInUsers < ActiveRecord::Migration
  def change
    rename_column :users, :core_tenured?, :bootstrapper?
  end
end
