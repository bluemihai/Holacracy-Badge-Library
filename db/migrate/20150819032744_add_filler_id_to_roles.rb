class AddFillerIdToRoles < ActiveRecord::Migration
  def change
    add_column :roles, :filler_id, :integer
  end
end
