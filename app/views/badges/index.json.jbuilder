json.array!(@badges) do |badge|
  json.extract! badge, :id, :name, :description, :proposer_id, :status, :proposal_date, :levels
  json.url badge_url(badge, format: :json)
end
