class AddLevelGrantedToBadgeNominations < ActiveRecord::Migration
  def change
    add_column :badge_nominations, :level_granted, :string
    rename_column :badge_nominations, :level, :level_nominated
  end
end
