class AddGroupToBadges < ActiveRecord::Migration
  def change
    add_column :badges, :group, :string
  end
end
