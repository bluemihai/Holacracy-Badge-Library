class CreateNominationVotes < ActiveRecord::Migration
  def change
    create_table :nomination_votes do |t|
      t.integer :badge_nomination_id
      t.integer :voter_id
      t.integer :level
      t.text :comment

      t.timestamps null: false
    end
  end
end
