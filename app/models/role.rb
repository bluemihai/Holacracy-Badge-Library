class Role < ActiveRecord::Base
  belongs_to :circle, class_name: 'Role'

  def sub_roles
    Role.all.select{ |r| r.circle == self }
  end

  def is_circle?
    sub_roles.count > 0
  end
  
  def delegated
    sub_roles.map(&:points).sum
  end
end
