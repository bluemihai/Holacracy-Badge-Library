class BadgeSetEntry < ActiveRecord::Base
  belongs_to :badge
  belongs_to :badge_set
  
  def badge_set_id_and_badge_name
    badge_set_id.to_s + ' ' + badge.try(:name).to_s
  end
end
