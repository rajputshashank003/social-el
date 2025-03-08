require 'net/http'
require 'json'

class LinkedInService
  LINKEDIN_API_URL = "https://api.linkedin.com/v2/ugcPosts"

  def initialize(access_token)
    @access_token = access_token
  end

  def create_post(post_data)
    uri = URI(LINKEDIN_API_URL)
    request = Net::HTTP::Post.new(uri)
    request["Authorization"] = "Bearer #{@access_token}"
    request["Content-Type"] = "application/json"
    
    request.body = post_data.to_json

    Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end
  end
end
