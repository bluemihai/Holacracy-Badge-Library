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

  it 'should return NEV with validation from pending badge holder for no-levels badge' do
    expect(@badge.has_levels?).to be true
    @badge.reset_levels
    expect(@badge.has_levels?).to be false

    @voter1 = FactoryGirl.create(:user)
    @voter2 = FactoryGirl.create(:user)
    @voter3 = FactoryGirl.create(:user, bootstrapper: true)
    @voter4 = FactoryGirl.create(:user, bootstrapper: true)
    @voter5 = FactoryGirl.create(:user, bootstrapper: true)
    @voter6 = FactoryGirl.create(:user, bootstrapper: true)
    expect(@bn.bootstrapper_majority).to eq(3)

    @voter1.grant_badge(@badge, 9)
    @bn2 = FactoryGirl.create(:badge_nomination, badge: @badge, user: @voter2, status: 'pending')
    expect(@bn2.accepted?).to be false
    expect(BadgeNomination.accepted.count).to eq(1)
    
    @v1 = @bn.validations.create(validator: @voter1)
    @v2 = @bn.validations.create(validator: @voter2)
    @v3 = @bn.validations.create(validator: @voter3)

    expect(@bn.accepted?).to be false    
    expect(@bn.current_level).to eq('NEV')

    expect(@bn.level_voted).to eq('NEV')
    expect(@bn.holder_votes.count).to eq(1)
    expect(@bn.bootstrapper_votes.count).to eq(1)

  end

end
