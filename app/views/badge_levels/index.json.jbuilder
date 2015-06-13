json.array!(@badge_levels) do |badge_level|
  json.extract! badge_level, :id, :badge_id, :level_id, :description
  json.url badge_level_url(badge_level, format: :json)
end
