class CompTier < ActiveRecord::Base
  
  def name_and_monthly_draw
    "#{name} - $#{monthly_draw}"
  end
end
