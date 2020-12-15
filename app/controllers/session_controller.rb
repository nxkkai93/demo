class SessionController < ApplicationController

	skip_before_action :verify_authenticity_token, :only => :create

  def create
  	user = User.find_or_create_by(:provider => auth_hash[:provider],  :uid => auth_hash[:uid]) do |user|
      user.email = auth_hash[:info][:email]
  		user.name = auth_hash[:info][:name]
      user.login = auth_hash[:extra][:raw_info][:login]

  	end

  	session[:user_id] = user.id
  	@user = auth_hash
  	redirect_to :pages_private
  end

  def destroy
  	reset_session


  	redirect_to :root
  end

  private
  def auth_hash
  	request.env["omniauth.auth"]
  	
  end
end
