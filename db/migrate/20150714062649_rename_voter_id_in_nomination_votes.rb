class RenameVoterIdInNominationVotes < ActiveRecord::Migration
  def change
    rename_column :nomination_votes, :voter_id, :validator_id
  end
end
