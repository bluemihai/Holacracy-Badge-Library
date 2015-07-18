# Feature: Nomination registered
#   As a user
#   I want to create a badge nomination
#   So that I or someone else can get approved for a badge
feature 'New Nomination' do

  # Scenario: User can sign in with valid account
  #   Given I have a valid account
  #   When I sign in
  #   And I create a new pending nomination
  #   And I visit the new nomination show page
  #   Then I see 'NEV'
  scenario "user can sign in with valid account" do
    signin
    u = FactoryGirl.create(:user)
    b = FactoryGirl.create(:badge)
    bn = FactoryGirl.create(:badge_nomination, user: u, badge: b, status: 'pending')
    expect(bn.user).to eq(u)
    expect(bn.badge).to eq(b)
    visit badge_nomination_path(bn)
    expect(page).to have_content("NEV")
  end
end