class SessionsController < ApplicationController

  def login
    already_logged_in?
    @user = User.new
end

def create
  @user = User.find_by(name: params[:user][:name])
  if @user && @user.authenticate(params[:user][:password])
    session[:user_id] = @user.id
    redirect_to home_path(@user)
  else
    render :login
  end
end

def facebook_create
       @new_user = User.find_or_create_by(uid: auth['uid']) do |u|
           u.name = auth['info']['name']
           u.email = auth['info']['email']
           u.image = auth['info']['image']
           u.password = User.generic_password
       end
       @new_user.save
       session[:user_id] = @new_user.id
       redirect_to home_path(@new_user)
   end

   def googleAuth
    #get access tokens from the google server
    access_token = request.env["omniauth.auth"]
    user = User.from_omniauth(access_token)
    log_in(user)
    # Access_token is used to authenticate request made from the rails application to the google server
    user.google_token = access_token.credentials.token
    #refresh_token to request new access_token
    #Note: Refresh_token is only sent once during the first request
    refresh_token = access_token.credentials.refresh_token
    user.google_refresh_token = refresh_token if refresh_token.present?
    user.save
    redirect_to home_path(@user)
   end


def destroy
  session[:user_id] = nil
  redirect_to root_path
end
end