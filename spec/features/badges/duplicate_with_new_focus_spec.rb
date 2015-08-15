# Feature: Nomination registered
#   As a user
#   I want to create a badge nomination
#   So that I or someone else can get approved for a badge
feature 'Duplicate with new focus' do

  # Scenario: User can duplicate badge with focus
  #   Given I have a valid account and sign in
  #   And I visit the badge library
  #   And there is at least one badge with focus
  #   When I click the "duplicate" link
  #   Then I see the text "New Badge"
  scenario "user can duplicate badge with focus" do
    signin
    expect(page).to have_content('HolacracyOne Badge Holders')
    b = FactoryGirl.create(:badge, status: 'accepted', description: 'Foo Bar Desc', name: 'Some Badge', focus: 'Focus X')
    p Badge.first
    expect(b.focus).to eq('Focus X')
    expect(b.has_focus?).to be true
    visit badges_path
    expect(page).to have_content('Some Badge (Focus X)')
    expect(page).to have_content('Duplicate')
    click_link 'Duplicate'
    expect(page).to have_content('Add New Badge')
    expect(page).to have_content('(Duplicated with New Focus)')
    expect(page).to have_content('Foo Bar Desc')
  end
end