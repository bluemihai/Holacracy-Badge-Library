require 'rails_helper'

RSpec.describe BadgeNomination, type: :model do 

  before(:each) do
    @user = FactoryGirl.create(:user)
    @badge = FactoryGirl.create(:badge)
    @bn = FactoryGirl.create(:badge_nomination, user: @user, badge: @badge)
  end

  it "#current_level should return correctly for badge nominations decided by grant" do
    @bn.update_attributes(status: 'accepted', level_granted: 4)    
    expect(@bn.current_level).to eq(4)
  end

  it "#current_level should return correctly for badge nominations decided by vote" do
    @bn.update_attributes(status: 'pending', level_nominated: 7)    

    @voter1 = FactoryGirl.create(:user)
    @voter2 = FactoryGirl.create(:user)
    @voter3 = FactoryGirl.create(:user)

    @voter1.grant_badge(@badge, 9)
    @voter2.grant_badge(@badge, 9)
    @voter3.grant_badge(@badge, 9)

    @v1 = @bn.validations.create(validator: @voter1, level: 4)
    @v2 = @bn.validations.create(validator: @voter2, level: 8)
    @v3 = @bn.validations.create(validator: @voter3, level: 6)

    expect(@bn.holder_votes.count).to eq(3)

    expect(@bn.current_level).to eq(6)
  end

  it '#pending should return only nominations that have an actual badge' do
    b = FactoryGirl.create(:badge, status: 'accepted')
    n = FactoryGirl.create(:badge_nomination, badge: b, status: 'pending')
    expect(n.badge).to eq(b)
    expect(BadgeNomination.pending.count).to eq(1)

    b.destroy!
    expect(BadgeNomination.pending.count).to eq(0)    
    
  end

end
