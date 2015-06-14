class Badge < ActiveRecord::Base
  has_many :badge_nominations
  has_many :users, through: :badge_nominations
  belongs_to :proposer, class_name: 'User'

  scope :accepted, -> { where(status: 'accepted') }
end
