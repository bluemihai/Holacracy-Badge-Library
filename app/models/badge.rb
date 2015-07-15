class Badge < ActiveRecord::Base
  has_many :badge_nominations
  has_many :holders, through: :badge_nominations, source: :user
  belongs_to :proposer, class_name: 'User'

  has_many :badge_set_entries
  has_many :badge_sets, through: :badge_set_entries

  scope :accepted, -> { where(status: 'accepted') }
  scope :proposed, -> { where(status: 'proposed') }
  scope :draft, -> { where(status: 'draft') }
  
  validates :name, presence: true
  validates :description, presence: true
  
  def current_holders
    badge_nominations.accepted.map{ |bn| bn.user.short + ' ' + bn.current_level }.join(', ')
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

  def has_no_levels?
    detailed_levels == []
  end
  
  def name_with_focus
    if name
      has_focus? ? name + ' (' + focus + ')' : name
    else
      has_focus? ? 'unnamed' + ' (' + focus + ')' : name
    end
  end

  def enough_holders
    holders.count >= 5
  end

end
