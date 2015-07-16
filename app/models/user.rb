class User < ActiveRecord::Base
  enum role: [:user, :comp_admin, :admin, :librarian]
  has_many :badge_nominations
  has_many :badges, through: :badge_nominations
  after_initialize :set_default_role, :if => :new_record?

  default_scope { order(:short) }
  scope :bootstrapper, -> { where(bootstrapper?: true) }

  def self.bootstrappers
    where(bootstrapper?: true).map{ |b| b.short}.join(', ')
  end

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
    bn = BadgeNomination.find_by(user_id: self.id, badge_id: badge.id)
    bn.try(:current_level)
  end

  def grant_badge(badge, level)
    badge_nominations.create(badge: badge, status: 'accepted', level_granted: level)
  end

  def has_badge(badge)
    bn = BadgeNomination.find_by(user_id: self.id, badge_id: badge.id)
    bn.try(:accepted?)
  end

  def nomination(badge)
    BadgeNomination.find_by(user_id: self.id, badge_id: badge.id)
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
