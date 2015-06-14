class Badge < ActiveRecord::Base
  has_many :badge_nominations
  has_many :holders, through: :badge_nominations, source: :user
  belongs_to :proposer, class_name: 'User'

  scope :accepted, -> { where(status: 'accepted') }
  
#  validates :name, presence: true, unique: true
  validates :description, presence: true
  validates :status, presence: true
  
  def accepted?
    status == 'accepted'
  end
end
