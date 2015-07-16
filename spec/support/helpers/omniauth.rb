module Omniauth

  module Mock
    def auth_mock
      OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
        'provider' => 'google_oauth2',
        'uid' => '123545',
        'info' => {
          'name' => 'Example User',
          'email' => 'example.user@holacracyone.com'
        },
        'credentials' => {
          'token' => 'mock_token',
          'secret' => 'mock_secret'
        }
      })
    end
  end

  module SessionHelpers
    def signin
      User.create(name: 'Example User')
      visit root_path
      expect(page).to have_content("Sign in with your H1 Gmail")
      auth = auth_mock
      click_link "Sign in with your H1 Gmail"
    end
  end

end
