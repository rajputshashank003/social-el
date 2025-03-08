require 'net/http'
require 'json'

class LinkedinPostsController < ApplicationController
  def index
    # Render the form in index.html.erb
  end

  def create
    post_content = params[:post_content]
    
    # Retrieve the access token stored in the session
    access_token = session[:linkedin_token]
    
    if access_token.nil?
      flash[:alert] = "Authentication required. Please log in with LinkedIn."
      redirect_to root_path and return
    end

    # Prepare the post data
    post_data = {
      "author": "urn:li:organization:105966173",  # Change to your LinkedIn organization ID
      "commentary": post_content,
      "visibility": "PUBLIC",
      "distribution": {
        "feedDistribution": "MAIN_FEED",
        "targetEntities": [],
        "thirdPartyDistributionChannels": []
      },
      "lifecycleState": "PUBLISHED",
      "isReshareDisabledByAuthor": false
    }

    # Make the API request
    response = LinkedInService.new(access_token).create_post(post_data)

    if response.code.to_i == 201
      flash[:notice] = "Post successfully created on LinkedIn!"
    else
      flash[:alert] = "Failed to post on LinkedIn: #{response.body}"
    end

    redirect_to root_path
  end
end
