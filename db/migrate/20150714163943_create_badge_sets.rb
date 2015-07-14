class CreateBadgeSets < ActiveRecord::Migration
  def change
    create_table :badge_sets do |t|
      t.integer :proposer_id
      t.string :name
      t.integer :comp_tier_id

      t.timestamps null: false
    end
  end
end
