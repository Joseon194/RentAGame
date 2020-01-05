class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    helper_method :current_user, :logged_in?, :user_not_authenticated?

    def current_user
        @user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end
    helper_method :current_user
end

    def logged_in?
        !!current_user
    end
    
    def user_not_authenticated?
        if !logged_in?
            redirect_to root_path
            return true
        end
        return false
    end
    
    def already_logged_in?
        if logged_in?
            redirect_to home_path(current_user)
            return true
        end
        return false
    end
    
    def to_user_not_authenticated?
        return if user_not_authenticated?
    end
    
    def to_already_logged_in?
        return if already_logged_in?
    end