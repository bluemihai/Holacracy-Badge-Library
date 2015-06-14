class NominationVote < ActiveRecord::Base
  belongs_to :badge_nomination
  belongs_to :voter, class_name: 'User'

  validates :badge_nomination_id, presence: true
  validates :voter_id, presence: true
  validates :level, presence: true
  
  validates_uniqueness_of :voter_id, scope: :badge_nomination_id, message: 'Sorry but you can only vote once!'
end
