class BadgeSetEntry < ActiveRecord::Base
  belongs_to :badge
  belongs_to :badge_set
end
