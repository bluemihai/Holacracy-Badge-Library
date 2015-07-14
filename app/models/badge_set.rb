class BadgeSet < ActiveRecord::Base
  belongs_to :proposer, class_name: 'User'
  belongs_to :comp_tier
  has_many :badge_set_entries
  has_many :badges, through: :badge_set_entries
end
