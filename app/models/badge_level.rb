class BadgeLevel < ActiveRecord::Base
  belongs_to :badge
  belongs_to :level
end
