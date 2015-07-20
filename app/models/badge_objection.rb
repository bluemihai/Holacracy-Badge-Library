class BadgeObjection < ActiveRecord::Base
  belongs_to :badge
  belongs_to :librarian, class_name: 'User'

  validates :badge_id, presence: true
  validates :librarian_id, presence: true
  validates :objection, presence: true

  validate :objector_must_be_librarian, :badge_must_be_proposed
  
  def objector_must_be_librarian
    if !librarian.is_librarian?
      errors.add(:librarian_id, "is not a Badge Librarian and therefore may not object")
    end
  end

  def badge_must_be_proposed
    if badge.status != 'proposed'
      errors.add(:badge, "is not in 'proposed' status, so you may not object to it")
    end
  end

end
