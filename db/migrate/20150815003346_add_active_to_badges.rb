class AddActiveToBadges < ActiveRecord::Migration
  def change
    add_column :badges, :active, :boolean, default: true
    add_column :badges, :removal_requested, :datetime
  end
end
