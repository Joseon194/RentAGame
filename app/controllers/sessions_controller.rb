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

def destroy
  session[:user_id] = nil
  redirect_to root_path
end
