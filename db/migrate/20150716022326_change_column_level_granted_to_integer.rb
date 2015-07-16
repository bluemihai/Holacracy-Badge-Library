class ChangeColumnLevelGrantedToInteger < ActiveRecord::Migration
  def change
    change_column :badge_nominations, :level_granted, "integer USING CAST(level_granted AS integer)"
  end
end
