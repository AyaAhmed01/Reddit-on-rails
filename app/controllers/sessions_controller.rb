class SessionsController < ApplicationController
    def create
        @user = User.find_by_credentials(user_params)
        unless @user.nil?
            log_in_user!(@user) 
        else
            flash.now[:errors] = "Incorrect user name and/or password"
            render :new 
        end
    end

    def new
        @user = User.new 
    end

    def destroy
        session[:session_token] = nil 
        current_user.reset_session_token!
        redirect_to new_session_url
    end

    private
    def user_params 
        params.require(:user).permit(:user_name, :password)
    end
end