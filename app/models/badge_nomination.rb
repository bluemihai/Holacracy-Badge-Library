class BadgeNomination < ActiveRecord::Base
  belongs_to :user
  belongs_to :badge
  has_many :nomination_votes
  has_many :votes, through: :nomination_votes

  validates :user_id, presence: true
  validates :badge_id, presence: true
  validates :level, presence: true
  validates :status, presence: true

  def accepted?
    status == 'accepted'
  end
  
  def who_for_what
    user.short + " for \'"  + badge.name + "\'"
  end
end
