class NominationVote < ActiveRecord::Base
  belongs_to :badge_nomination
  belongs_to :voter, class_name: 'User'
end
