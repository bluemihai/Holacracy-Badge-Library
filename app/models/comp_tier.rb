class CompTier < ActiveRecord::Base
  has_many :badge_sets
  
  def name_and_monthly_draw
    "#{name} - $#{monthly_draw}"
  end
  
  def self.tier(n)
    CompTier.all.select{ |t| t.name.starts_with?(n.to_s) }
  end
end
