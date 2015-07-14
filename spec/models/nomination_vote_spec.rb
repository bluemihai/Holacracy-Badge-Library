require 'rails_helper'

RSpec.describe NominationVote, type: :model do

  it 'should fail when self-validating' do
    u = FactoryGirl.create(:user)
    n = FactoryGirl.create(:badge_nomination, user: u)
    v = FactoryGirl.build(:nomination_vote, badge_nomination: n, validator: u, level: 9)

    expect(v).to be_invalid
  end
  
end
