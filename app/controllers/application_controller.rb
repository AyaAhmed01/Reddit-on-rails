class ApplicationController < ActionController::Base
    
    # Expose these methods to the views
    helper_method :current_user, :logged_in?

    private 
    def current_user
        @current_user ||= User.find_by(session_token: session[:session_token])
    end

    def logged_in?
        !session[:session_token].nil?
    end

    def log_in_user!(user)
        @current_user = user 
        session[:session_token] = user.try(:reset_session_token!)
    end

    def require_signed_in!
        redirect_to new_session_url unless logged_in?
    end

    def require_signed_out!
        redirect_to subs_url if logged_in?
    end

    def log_out
        session[:session_token] = nil 
        current_user.try(:reset_session_token!)
    end
end
