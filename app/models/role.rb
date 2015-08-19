class Role < ActiveRecord::Base
  belongs_to :circle, class_name: 'Role'
  belongs_to :filler, class_name: 'User'

  validate :within_budget

  def sub_roles
    Role.all.select{ |r| r.circle == self }
  end

  def is_circle?
    sub_roles.count > 0
  end
  
  def delegated
    return nil unless is_circle?
    sub_roles.map(&:points).sum
  end

  def controlled
    points.to_i - delegated.to_i
  end
  
  private
  
    def within_budget
      if points > circle.controlled
        errors.add(:points, "Your super circle only has #{circle.controlled} points left to control.  Try (1) using those, (2) reallocating from other roles or (3) asking for more from your super circle's super circle.")
      end
    end

end
