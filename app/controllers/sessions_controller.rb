class SessionsController < ApplicationController
    before_action :require_signed_out!, only: [:create, :new]

    def create
        @user = User.find_by_credentials(
            params[:user][:user_name], 
            params[:user][:password]
            ) 
        if @user.nil?
            flash.now[:errors] = "Incorrect user name and/or password"
            render :new 
        # You can use User#activated? even you didn't define it!
        # Rails gives you this method for free because it matches a column name.
        elsif @user.activated?    
            log_in_user!(@user) 
            redirect_to subs_url
        else
            flash.now[:errors] = "You must activate your account first!, check your email"
            render :new 
        end   
    end

    def new
        @user = User.new 
    end

    def destroy
        session[:session_token] = nil 
        current_user.try(:reset_session_token!)
        redirect_to new_session_url
    end
end