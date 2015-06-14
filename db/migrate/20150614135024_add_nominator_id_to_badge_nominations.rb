class AddNominatorIdToBadgeNominations < ActiveRecord::Migration
  def change
    add_column :badge_nominations, :nominator_id, :integer
  end
end
