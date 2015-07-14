json.array!(@badge_set_entries) do |badge_set_entry|
  json.extract! badge_set_entry, :id, :badge_set_id, :badge_id, :level
  json.url badge_set_entry_url(badge_set_entry, format: :json)
end
