class AddFocusToBadges < ActiveRecord::Migration
  def change
    add_column :badges, :focus, :string
  end
end
