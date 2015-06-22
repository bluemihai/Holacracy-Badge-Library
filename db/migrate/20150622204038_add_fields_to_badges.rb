class AddFieldsToBadges < ActiveRecord::Migration
  def change
    add_column :badges, :feedback, :text
    add_column :badge_nominations, :evidence, :text
  end
end
