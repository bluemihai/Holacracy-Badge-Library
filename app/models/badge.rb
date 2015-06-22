class Badge < ActiveRecord::Base
  has_many :badge_nominations
  has_many :holders, through: :badge_nominations, source: :user
  belongs_to :proposer, class_name: 'User'

  scope :accepted, -> { where(status: 'accepted') }
  
  validates :name, presence: true
  validates :description, presence: true
  
  def accepted?
    status == 'accepted'
  end

  def detailed_levels
    (1..9).map{ |i| [i.to_s + ': ' + send('level_' + i.to_s), i] }
  end

  def has_focus?
    focus && focus != ''
  end
  
  def name_with_focus
    if name
      has_focus? ? name + ' (' + focus + ')' : name
    else
      has_focus? ? 'unnamed' + ' (' + focus + ')' : name
    end
  end
end
