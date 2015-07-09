class AddEffectiveDateToBadgeNominations < ActiveRecord::Migration
  def change
    add_column :badge_nominations, :effective_date, :date
  end
end
