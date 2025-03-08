class SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    
    if auth.present?
      user = User.find_or_create_by(uid: auth['uid'], provider: auth['provider']) do |u|
        u.name = auth['info']['name']
        u.nickname = auth['info']['nickname']
        u.image = auth['info']['image']
        u.token = auth['credentials']['token']
        u.secret = auth['credentials']['secret'] if auth['credentials']['secret'].present?
      end

      session[:user_id] = user.id
      flash[:notice] = "Signed in successfully with #{auth['provider'].capitalize}!"
    else
      flash[:alert] = "Authentication failed! No data received."
    end

    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Signed out successfully!"
    redirect_to root_path
  end

  def failure
    flash[:alert] = "Authentication failed!"
    redirect_to root_path
  end
end
