class AddStatusToBadgeNominations < ActiveRecord::Migration
  def change
    add_column :badge_nominations, :status, :string
  end
end
