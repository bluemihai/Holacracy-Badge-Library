class AddFocusToUsers < ActiveRecord::Migration
  def change
    add_column :users, :focus_time, :integer, default: 100
    rename_column :users, :comp_tier_id, :badge_set_id
  end
end
