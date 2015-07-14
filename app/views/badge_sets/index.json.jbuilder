json.array!(@badge_sets) do |badge_set|
  json.extract! badge_set, :id, :proposer_id, :name, :comp_tier_id
  json.url badge_set_url(badge_set, format: :json)
end
