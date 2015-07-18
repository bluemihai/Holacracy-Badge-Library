class BadgeNomination < ActiveRecord::Base
  belongs_to :user
  belongs_to :badge
  has_many :validations, class_name: 'NominationVote', dependent: :destroy
  has_many :validators, through: :validations, class_name: 'User'
  belongs_to :nominator, class_name: 'User'

  validates :user_id, presence: true
  validates :badge_id, presence: true
  validates_with 
#  validates :status, presence: true

  validates_uniqueness_of :user_id, scope: :badge_id, message: "User has already been nominated for this badge."

  scope :pending, -> { where(status: 'pending').joins(:badge) }
  scope :accepted, -> { where(status: 'accepted') }

  def accepted?
    return true if status == 'accepted'
    if badge.has_levels?
      current_level && current_level.is_a?(Integer) && current_level > 0
    else
      current_level == true
    end
  end

  def nominated_badge_name
    badge.try(:name) || '(Since Deleted)'
  end

  def short_name_for_badge_level
    who = user.short || 'User Missing'
    what = badge.name || 'Badge Missing'
    base = who + " for "  + what
    badge.try(:has_levels?) ? base + ", Level " + level_nominated.to_s : base
  end

  def name_for_badge
    who = user.name || 'User Missing'
    what = badge.name || 'Badge Missing'
    who + " for "  + what
  end

  def current_level
    if status == 'expired'
      'EXP'
    elsif status == 'accepted'
      return true if !badge.has_levels?
      (level_granted.nil? || level_granted == '' || level_granted == 0) ? 'COMP' : level_granted
    elsif holder_votes.count > 1
      level_voted
    else
      level_bootstrapped
    end
  end

  def level_voted
    return 'NEV' unless holder_votes.count > 1
    badge.has_levels? ? holder_votes.map(&:level).sort.reverse[1] : true
  end

  def holder_votes
    return [] unless badge && badge.holders
    validations.select { |v| v.validator.has_badge(badge) }
  end

  def bootstrapper_majority
    (User.bootstrapper.count / 2.0).floor + 1
  end

  def level_bootstrapped
    return 'NEV' if bootstrapper_votes.count < bootstrapper_majority
    if badge.has_levels?
      bootstrapper_votes.sort{ |v| -v.level }[bootstrapper_majority - 1].level rescue nil
    else
      bootstrapper_votes.count >= bootstrapper_majority ? true : 'NEV'
    end
  end

  def bootstrapper_votes
    return [] unless validations && validations.count
    validations.select { |v| v.validator && v.validator.bootstrapper? }
  end

  def enough_badge_holders
    badge.enough_holders
  end

end
