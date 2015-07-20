class Badge < ActiveRecord::Base
  has_many :badge_nominations
  has_many :holders, through: :badge_nominations, source: :user
  belongs_to :proposer, class_name: 'User'

  has_many :badge_set_entries
  has_many :badge_sets, through: :badge_set_entries
  has_many :objections, class_name: 'BadgeObjection'

  scope :accepted, -> { where(status: 'accepted') }
  scope :proposed, -> { where(status: 'proposed') }
  scope :draft, -> { where(status: 'draft') }
  
  validates :name, presence: true
  validates :description, presence: true
  
  def current_holders
    badge_nominations.select{ |bn| bn.accepted? }.map{ |bn| bn.user }
  end

  def current_holder_names
    holders = badge_nominations.select{ |bn| bn.accepted? }.map{ |bn| bn.user.short + ' ' + bn.current_level.to_s }
    holders.count > 0 ? holders.join(', ') : 'There are no current badge holders'
  end
  
  def accepted?
    status == 'accepted'
  end

  def detailed_levels
    (1..9).map{ |i| [i.to_s + ': ' + send('level_' + i.to_s), i] unless send('level_' + i.to_s) == '' }.compact
  end

  def has_focus?
    focus && focus != ''
  end

  def has_levels?
    detailed_levels != []
  end
  
  def name_with_focus
    if name
      has_focus? ? name + ' (' + focus + ')' : name
    else
      has_focus? ? 'unnamed' + ' (' + focus + ')' : name
    end
  end

  def safe_name_with_focus
    name ? name_with_focus : '(Badge Missing)'
  end

  def enough_holders
    holders.count >= 5
  end

  def reset_levels
    update_attributes(
      level_1: '',
      level_2: '',
      level_3: '',
      level_4: '',
      level_5: '',
      level_6: '',
      level_7: '',
      level_8: '',
      level_9: ''
    )
  end
end
