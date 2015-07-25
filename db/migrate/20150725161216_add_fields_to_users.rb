class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :glassfrog_id, :integer
    add_column :users, :comp_tier_id, :integer
    add_column :users, :legacy_p_unit_grant, :integer
    add_column :users, :librarian?, :boolean, default: false
    add_column :users, :comp_admin?, :boolean, default: false
  end
end
