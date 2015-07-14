json.array!(@comp_tiers) do |comp_tier|
  json.extract! comp_tier, :id, :name, :monthly_draw, :fixed_draw
  json.url comp_tier_url(comp_tier, format: :json)
end
