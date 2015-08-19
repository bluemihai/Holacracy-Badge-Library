class Role < ActiveRecord::Base
  @@points_being_changed = 0

  belongs_to :circle, class_name: 'Role'
  belongs_to :filler, class_name: 'User'
  before_validation :store_points

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
      old_points = new_record? ? 0 : Role.find_by_id(self.id).try(:points)
        if points > circle.controlled + old_points
          message = "This role's circle has #{circle.controlled} unallocated points. "
          option = old_points ? "Before editing, the role had #{old_points}. " : " "
          solution_1 = "Try (1) asking for #{circle.controlled + old_points} points or fewer, "
          solution_2 = "(2) reallocating from other roles in the circle or "
          solution_3 = "(3) asking for more points for your super circle from its super circle."
          errors.add(:points, message + option + solution_1 + solution_2 + solution_3)
        end
    end
    
    def store_points
      @@points_being_changed = points
    end

end
