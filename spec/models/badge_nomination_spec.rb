require 'rails_helper'

RSpec.describe BadgeNomination, type: :model do 

  it "#level_voted should return 5 when bootstrapper votes are placed" do
    bn = FactoryGirl.create(:badge_nomination)
    bootstrappers = (1..4).map {FactoryGirl.create(:user, bootstrapper?: true)}
    bn.validations = (1..4).map { |i| FactoryGirl.create(:nomination_vote, level: i + 3, validator_id: i)}
      
    expect(bn.level_voted).to eq(5)
  end

  it "#level_voted should return nil when only 2 bootstrapper votes are placed" do
    bn = FactoryGirl.create(:badge_nomination)
    bootstrappers = (1..2).map {FactoryGirl.create(:user, bootstrapper?: true)}
    bn.validations = (1..2).map { |i| FactoryGirl.create(:nomination_vote, level: rand(9) + 1, validator_id: i)}

    expect(bn.level_voted).to be_nil
  end

end
