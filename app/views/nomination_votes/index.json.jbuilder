json.array!(@nomination_votes) do |nomination_vote|
  json.extract! nomination_vote, :id, :badge_nomination_id, :voter_id, :level, :comment
  json.url nomination_vote_url(nomination_vote, format: :json)
end
