class CreateBadges < ActiveRecord::Migration
  def change
    create_table :badges do |t|
      t.string :name
      t.text :description
      t.integer :proposer_id
      t.string :status
      t.date :proposal_date
      t.integer :levels
      t.text :level_1
      t.text :level_2
      t.text :level_3
      t.text :level_4
      t.text :level_5
      t.text :level_6
      t.text :level_7
      t.text :level_8
      t.text :level_9

      t.timestamps null: false
    end
  end
end
