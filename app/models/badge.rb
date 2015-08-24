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

  def relevant_date
    if status == 'accepted'
      acceptance_date || created_at.to_date
    elsif status == 'proposed'
      proposal_date || created_at.to_date
    else
      created_at.to_date
    end
  end

  def self.filter_by(group, status)
    return Badge.all if group == nil && status == nil
    has_group = Badge.where(group: group)
    has_status = Badge.where(status: status)

    return has_status if has_group == []
    return has_group if has_status == []
    has_group & has_status
  end

  def self.groups
    Badge.pluck(:group).compact.uniq
  end

  def active_or_not
    if active?
      removal_requested? ? "active, removal requested #{removal_requested.strftime('%b-%d')}" : 'active'
    else
      'inactive'
    end
  end

  def status_with_date
    return nil if status == nil
    if status == 'accepted'
      acceptance_date ? status.capitalize + ' on ' + acceptance_date.strftime('%b-%-d') : status.capitalize
    elsif status == 'proposed'
      proposal_date ? status.capitalize + ' on ' + proposal_date.strftime('%b-%-d') : status.capitalize
    else
      status.capitalize
    end    
  end

  # TODO: make sure voted badges still included
  def current_holders
    badge_nominations.select{ |bn| bn.accepted? }.map{ |bn| bn.user }
  end

  def current_holder_emails
    current_holders.map(&:mailto).join(', ')
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
