require 'rails_helper'

RSpec.describe Badge, type: :model do
  before(:all) do
  end

  it "should return true with 5 badge holders" do
    good_users = (1..5).map { FactoryGirl.create(:user) }
    good_badge = FactoryGirl.create(:badge)
    good_badge.holders = good_users

    expect(good_badge.enough_holders).to be true
  end

  it "should return false with 4 badge holders" do
    bad_users = (1..4).map { FactoryGirl.create(:user) }
    bad_badge = FactoryGirl.create(:badge) 
    bad_badge.holders = bad_users

    expect(bad_badge.enough_holders).to be false
  end
  
end
