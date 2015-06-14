class BadgeNomination < ActiveRecord::Base
  belongs_to :user
  belongs_to :badge
  has_many :nomination_votes
  has_many :votes, through: :nomination_votes

  def accepted?
    status == 'accepted'
  end
end
