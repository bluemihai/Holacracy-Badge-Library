Rails.application.config.middleware.use OmniAuth::Builder do
  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE if Rails.env.development? || Rails.env.test?
  provider :google_oauth2, Rails.application.secrets.omniauth_provider_key, Rails.application.secrets.omniauth_provider_secret, {access_type: 'online', approval_prompt: ''}
end
