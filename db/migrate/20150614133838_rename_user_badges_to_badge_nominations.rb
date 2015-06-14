class RenameUserBadgesToBadgeNominations < ActiveRecord::Migration
  def change
    rename_table :user_badges, :badge_nominations
  end
end
