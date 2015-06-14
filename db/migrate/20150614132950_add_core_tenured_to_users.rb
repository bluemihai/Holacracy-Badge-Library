class AddCoreTenuredToUsers < ActiveRecord::Migration
  def change
    add_column :users, :core_tenured?, :boolean, default: false
  end
end
