class Badge < ActiveRecord::Base
  has_many :badge_levels
  has_many :levels, through: :badge_levels
  has_many :user_badges
  has_many :users, through: :user_badges
  belongs_to :proposer, class_name: 'User'
end
