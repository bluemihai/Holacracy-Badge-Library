class BadgeNomination < ActiveRecord::Base
  belongs_to :user
  belongs_to :badge
  has_many :votes, class_name: 'NominationVote'
  has_many :voters, through: :nomination_votes

  validates :user_id, presence: true
  validates :badge_id, presence: true
  validates :level_nominated, presence: true
  validates :status, presence: true

  validates_uniqueness_of :user_id, scope: :badge_id, message: "User has already been nominated for this badge."

  def accepted?
    status == 'accepted'
  end
  
  def who_for_what
    user.short + " for \'"  + badge.name + "\' at level " + level_nominated
  end

  def enough_badge_holders
    badge.holders.count > 5
  end

  def level_voted
    if enough_badge_holders
      valid_votes = votes.select{ |v| badge.holders.include?(v.voter) }
    else
      valid_votes = votes.select{ |v| badge.holders.include?(v.voter) || v.voter.core_tenured? }
    end

    if valid_votes.count < 3    # we don't have enough votes
      return nil 
    else
      levels = valid_votes.map(&:level).sort.reverse
      levels[2]
    end
  end
end
