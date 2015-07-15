require 'rails_helper'

RSpec.describe BadgeNomination, type: :model do 

  it '#pending should return only nominations that have an actual badge' do
    b = FactoryGirl.create(:badge, status: 'accepted')
    n = FactoryGirl.create(:badge_nomination, badge: b, status: 'pending')
    expect(n.badge).to eq(b)
    expect(BadgeNomination.pending.count).to eq(1)

    b.destroy!
    expect(BadgeNomination.pending.count).to eq(0)    
    
  end

end
