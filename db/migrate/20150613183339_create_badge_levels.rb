class CreateBadgeLevels < ActiveRecord::Migration
  def change
    create_table :badge_levels do |t|
      t.integer :badge_id
      t.integer :level_id
      t.string :description

      t.timestamps null: false
    end
  end
end
