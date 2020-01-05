class UsersController < ApplicationController
  before_action :to_already_logged_in?, except: [:home, :reviewed_games]

def new
  @user = User.new
end

def create
  @user = User.new user_params
  if @user.valid? && @user.save
    session[:user_id] = @user.id
    redirect_to home_path(@user)
  else
    render :new
  end
end

def home
  user_not_authenticated?
  current_user
end

def reviewed_games
  @user = current_user
end

private

def user_params
  params.require(:user).permit(:name, :email, :password, :password_confirmation)
end

def self.from_omniauth(auth)
  where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
    user.provider = auth.provider
    user.uid = auth.uid
    user.name = auth.info.name
    user.oauth_token = auth.credentials.token
    user.oauth_expires_at = Time.at(auth.credentials.expires_at)
    user.save!
end
end 
end
