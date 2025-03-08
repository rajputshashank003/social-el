class TweetsController < ApplicationController
  def new
  end

  def create
    if current_user.token.present? && current_user.secret.present?
      client = Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV['TWITTER_API_KEY']
        config.consumer_secret     = ENV['TWITTER_API_SECRET']
        config.access_token        = current_user.token
        config.access_token_secret = current_user.secret
      end

      begin
        client.update(params[:message])
        flash[:notice] = "Tweet posted successfully!"
      rescue Twitter::Error => e
        flash[:alert] = "Failed to post tweet: #{e.message}"
      end
    else
      flash[:alert] = "You need to authenticate with Twitter first!"
    end

    redirect_to root_path
  end
end
