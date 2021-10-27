class ApplicationController < ActionController::Base
    helper_method :current_user, :logged_in?

    def current_user
        @current_user ||= User.find_by(session_token: session[:session_token])
        return  @current_user if logged_in?
        nil 
    end

    def logged_in?
        !session[:session_token].nil?
    end

    def log_in_user!(user)
        @current_user = user 
        session[:session_token] = user.reset_session_token!
    end

    def require_log_in
        redirect_to new_session_url unless logged_in?
    end
end
