class User < ActiveRecord::Base
  enum role: [:user, :vip, :admin, :librarian]
  has_many :badge_nominations
  has_many :badges, through: :badge_nominations
  after_initialize :set_default_role, :if => :new_record?

  default_scope { order(:short) }

  def badge_count
    badges.count
  end

  def is_librarian?
    role == 'librarian'
  end

  def is_admin?
    role == 'admin'
  end

  # return a BadgeNomination object with the highest badge level held by user
  def badge_level(badge)
    badge_nominations.where(badge_id: badge.id, status: 'accepted').order('level DESC').try(:first).try(:level)
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
