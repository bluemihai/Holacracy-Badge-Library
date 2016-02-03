class User < ActiveRecord::Base
  enum role: [:user, :comp_admin, :admin, :librarian]

  has_many :badge_nominations
  has_many :badges, through: :badge_nominations
  belongs_to :badge_set

  after_initialize :set_default_role, :if => :new_record?

  default_scope { order(:short) }
  scope :bootstrapper, -> { where(bootstrapper: true) }
  scope :active, -> { where(active: true) }
  scope :librarians, -> { where(librarian: true) }

  has_many :roles, foreign_key: :filler_id

  def attention_points
    roles.map(&:controlled).sum
  end

  def percent_focus
    attention_points / 80.0
  end

  def self.role_fillers
    roles = Role.pluck(:filler_id).uniq.compact
    roles == [] ? nil : User.find(Role.pluck(:filler_id))
  end

  def self.random
    offset(rand(6)).first
  end

  def monthly_draw
    (badge_set ? badge_set.comp_tier.monthly_draw  : legacy_p_unit_grant) * focus_time / 100
  end

  def gravatar(size=24)
    gravatar_id = Digest::MD5.hexdigest(email.downcase) unless email.blank?
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}&d=monsterid"    
  end

  def self.bootstrappers
    where(bootstrapper: true).map{ |b| b.short}.join(', ')
  end

  def badges_pending
    badge_nominations.pending.map{ |bn| bn.badge unless bn.accepted? }.compact
  end

  def badges_held
    badge_nominations.map{ |bn| bn.badge if bn.accepted? }.compact
  end

  def is_admin?
    role == 'admin'
  end

  def is_comp_admin?
    role == 'comp_admin'
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
  
  def safe_name
    name ? name : '(User Name Missing)'
  end
  
  def safe_short_name
    short ? short : '(Short User Name Missing)'
  end

  def mailto
    name + ' <' + email + '>'
  end

end
