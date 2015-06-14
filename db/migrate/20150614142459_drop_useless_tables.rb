class DropUselessTables < ActiveRecord::Migration
  def change
    drop_table :levels
    drop_table :badge_levels
  end
end
