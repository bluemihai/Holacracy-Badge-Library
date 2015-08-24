require 'rails_helper'

RSpec.describe Badge, type: :model do
  before(:all) do
    @users = (1..5).map { FactoryGirl.create(:user) }
  end

  it "#enough_holders should return true with 5 badge holders" do
    good_users = @users
    good_badge = FactoryGirl.create(:badge)
    good_badge.holders = good_users

    expect(good_badge.enough_holders).to be true
  end

  it "#enough_holders should return false with 4 badge holders" do
    bad_users = @users.first(4)
    bad_badge = FactoryGirl.create(:badge) 
    bad_badge.holders = bad_users

    # pp BadgeNomination.all
    # pp bad_users.map { |u| u.badges_held }

    expect(bad_badge.enough_holders).to be false
  end

  it "#current_holders works" do
    b = FactoryGirl.create(:badge)
    b.holders = @users.last(3)
    expect(b.current_holders.count).to eq(0)

    b.badge_nominations.each { |bn| bn.grant }
    expect(b.current_holders.count).to eq(3)
    expect(b.current_holders[0]).to eq(@users[2])
    expect(b.current_holders[1]).to eq(@users[3])
    expect(b.current_holders[2]).to eq(@users[4])
  end
  
end
