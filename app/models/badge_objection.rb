class BadgeObjection < ActiveRecord::Base
  belongs_to :badge
  belongs_to :librarian, class_name: 'User'

  validates :badge_id, presence: true
  validates :librarian_id, presence: true
  validates_uniqueness_of :librarian_id, scope: :badge_id, message: "User has already objected to this badge."  

#  validate :badge_must_be_proposed, :objection_must_not_be_nil#, :objector_must_be_librarian

  def objection_name_date
    o = objection ? 'Objection' : 'No Objection'
    o + ' from ' + librarian.short + ' on ' + created_at.strftime('%b-%-d')
  end

  private
    # def badge_must_be_proposed
    #   if badge.status != 'proposed'
    #     errors.add(:badge, "is not in 'proposed' status, so you may not object to it")
    #   end
    # end
    #
    # def objection_must_not_be_nil
    #   if objection.nil?
    #     errors.add(:objection, "has to be either true or false")
    #   end
    # end
    #
    # def objector_must_be_librarian
    #   if !librarian.librarian?
    #     raise
    #     errors.add(:librarian_id, "is not a Badge Librarian and therefore may not object")
    #   end
    # end
end
