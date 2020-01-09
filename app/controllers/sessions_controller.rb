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

   def googleAuth
    #get access tokens from the google server
    access_token = request.env["omniauth.auth"]
    user = User.from_omniauth(access_token)
    user.password = User.generic_password
    #login(user)
    # Access_token is used to authenticate request made from the rails application to the google server
    #user.google_token = access_token.credentials.token
    #refresh_token to request new access_token
    #Note: Refresh_token is only sent once during the first request
    #refresh_token = access_token.credentials.refresh_token
    #user.google_refresh_token = refresh_token if refresh_token.present?
    if user.save
    session[:user_id] = user.id
    redirect_to home_path(user)
    else
      render :new
   end
  end 

   def auth
    request.env["omniauth.auth"]
   end

def destroy
  session[:user_id] = nil
  redirect_to root_path
end
end