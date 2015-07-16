class NominationVote < ActiveRecord::Base
  belongs_to :badge_nomination
  belongs_to :validator, class_name: 'User'

  validates :badge_nomination_id, presence: true
  validates :validator_id, presence: true
  # validates :level, presence: true
  
  validates_uniqueness_of :validator_id, scope: :badge_nomination_id, message: 'Sorry but you can validate once per nomination!'
  validate :cannot_self_validate

  def badge
    badge_nomination.badge
  end

  def cannot_self_validate
    if validator == badge_nomination.user
      errors.add(:validator_id, "can't be the same as badge nominee")
    end
  end

end
