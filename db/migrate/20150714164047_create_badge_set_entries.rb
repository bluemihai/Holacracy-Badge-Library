class CreateBadgeSetEntries < ActiveRecord::Migration
  def change
    create_table :badge_set_entries do |t|
      t.integer :badge_set_id
      t.integer :badge_id
      t.integer :level

      t.timestamps null: false
    end
  end
end
