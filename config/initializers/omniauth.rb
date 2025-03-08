Rails.application.config.middleware.use OmniAuth::Builder do
  provider :linkedin, 
    Rails.application.credentials.dig(:linkedin, :client_id) || ENV['LINKEDIN_CLIENT_ID'],
    Rails.application.credentials.dig(:linkedin, :client_secret) || ENV['LINKEDIN_CLIENT_SECRET'],
    scope: 'w_member_social,r_liteprofile,r_emailaddress'
  provider :twitter, 
    ENV['TWITTER_API_KEY'], ENV['TWITTER_API_SECRET']
end
