class CreateBadges < ActiveRecord::Migration
  def change
    create_table :badges do |t|
      t.string :name
      t.text :description
      t.integer :proposer_id
      t.string :status, default: 'Proposed'
      t.date :proposal_date
      t.integer :levels, default: 9

      t.timestamps null: false
    end
  end
end
