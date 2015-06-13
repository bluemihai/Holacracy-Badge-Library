class Level < ActiveRecord::Base
  has_many :badge_levels
  has_many :badges, through: :badge_levels
end
