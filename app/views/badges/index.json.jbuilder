json.array!(@badges) do |badge|
  json.extract! badge, :id, :name, :description, :proposer_id, :status, :proposal_date, :levels, :level_1, :level_2, :level_3, :level_4, :level_5, :level_6, :level_7, :level_8, :level_9
  json.url badge_url(badge, format: :json)
end
