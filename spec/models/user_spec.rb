describe User do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @badge = FactoryGirl.create(:badge)
  end

  subject { @user }

  it { should respond_to(:name) }

  it "#librarian? works" do
    expect(@user.librarian).to be false
    @user.update_attributes(librarian: true)
    expect(@user.librarian).to be true
  end

  it "#name returns a string" do
    expect(@user.name).to match 'Test User'
  end

  it "#badge_level should return the right level for granted badge" do
    @bn = FactoryGirl.create(:badge_nomination, user: @user, badge: @badge, status: 'accepted', level_granted: 5)
    expect(@user.badge_level(@badge)).to eq(5)
  end

  it "#badge_level should return the right level for badge with enough votes" do
    @voter1 = FactoryGirl.create(:user)
    @voter2 = FactoryGirl.create(:user)
    @voter3 = FactoryGirl.create(:user)

    @voter1.grant_badge(@badge, 6)
    @voter2.grant_badge(@badge, 9)
    @voter3.grant_badge(@badge, 4)

    @bn = FactoryGirl.create(:badge_nomination, user: @user, badge: @badge, status: 'pending', level_nominated: 8)

    @bn.validations.create(validator: @voter1, level: 5)
    @bn.validations.create(validator: @voter2, level: 6)
    @bn.validations.create(validator: @voter3, level: 7)
    
    expect(@user.badge_level(@badge)).to eq(6)
  end

end
