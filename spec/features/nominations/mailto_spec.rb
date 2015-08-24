# Feature: Nomination registered
#   As a user
#   I want a mailto: link for badge holders
#   So that I can request validations as quickly as possible
feature 'New Nomination' do

  # Scenario: User sees mailto link on nomination show page
  #   Given I have a valid account
  #   When I sign in
  #   And I create a new pending nomination
  #   And I visit the new nomination show page
  #   Then I see 'Request validations'
  scenario "badge_nomination#show includes link to request validations" do
    signin
    u = FactoryGirl.create(:user)
    b = FactoryGirl.create(:badge)
    bn = FactoryGirl.create(:badge_nomination, user: u, badge: b, status: 'pending')
    expect(bn.user).to eq(u)
    expect(bn.badge).to eq(b)
    visit badge_nomination_path(bn)
    expect(page).to have_content("Request validations")
  end
end