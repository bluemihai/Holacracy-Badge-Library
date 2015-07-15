class BadgeNomination < ActiveRecord::Base
  belongs_to :user
  belongs_to :badge
  has_many :validations, class_name: 'NominationVote'
  has_many :validators, through: :validations, class_name: 'User'
  belongs_to :nominator, class_name: 'User'

  validates :user_id, presence: true
  validates :badge_id, presence: true
#  validates :status, presence: true

  validates_uniqueness_of :user_id, scope: :badge_id, message: "User has already been nominated for this badge."

  scope :pending, -> { where(status: 'pending').joins(:badge) }
  scope :accepted, -> { where(status: 'accepted') }

  def accepted?
    status == 'accepted'
  end

  def nominated_badge_name
    badge.try(:name) || '(Since Deleted)'
  end

  def who_for_what
    user.short + " for \'"  + nominated_badge_name + "\' at level " + level_nominated.to_s
  end

  def current_level
    if status == 'expired'
      'Exp'
    elsif status == 'accepted'
      (level_granted.nil? || level_granted == '') ? 'COMP' : level_granted
    else
      level_voted.nil? ? 'NEV' : level_voted
    end
  end

  def holder_votes
    return [] unless badge && badge.holders
    validations.select { |v| badge.holders.include?(v.validator) }.sort{ |v| -v.level}
  end

  def bootstrapper_votes
    return [] unless validations && validations.count
    validations.select { |v| v.validator && v.validator.bootstrapper? }.sort{ |v| -v.level}
  end

  def valid_votes
    return holder_votes if holder_votes.count > 4
    return bootstrapper_votes if holder_votes.count == 0
    holder_votes.concat(bootstrapper_votes).uniq.take(5)
  end

  def level_voted
    return nil if valid_votes.count < 3    # we don't have enough votes
    valid_votes.map(&:level).sort.reverse[2]
  end

  def enough_badge_holders
    badge.enough_holders
  end

end
