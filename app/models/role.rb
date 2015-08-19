class Role < ActiveRecord::Base
  belongs_to :circle, class_name: 'Role'
  belongs_to :filler, class_name: 'User'

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

end
