class User < ActiveRecord::Base
  enum role: [:user, :vip, :admin, :librarian]
  has_many :user_badges
  has_many :badges, through: :user_badges
  after_initialize :set_default_role, :if => :new_record?

  def badge_count
    badges.count
  end

  def is_librarian?
    role == 'librarian'
  end

  def is_admin?
    role == 'admin'
  end

  def badge_level(badge)
    ub = UserBadge.where(user: self.id, badge: badge.id).first
    ub.try(:level) || '-'
  end

  def set_default_role
    if User.count == 0
      self.role ||= :admin
    else
      self.role ||= :user
    end
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
         user.name = auth['info']['name'] || ""
      end
    end
  end

end
