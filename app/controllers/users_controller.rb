class UsersController < ApplicationController
    before_action :require_signed_out!, only: [:create, :new]
    
    def create 
        @user = User.new(user_params)
        if @user.save
            email = UserMailer.activation_email(@user)
            email.deliver_now    # send the activation email to user email 
            flash[:notice] = "Successfully created your account! check your inbox for an activation email" 
            redirect_to new_session_url 
        else
            flash.now[:errors] = @user.errors.full_messages
            render :new 
        end
    end

    def new 
        @user = User.new 
    end

    def show 
        @user = User.find(params[:id])
        @subs = @user.subs
        @posts = @user.posts 
        @comments = @user.comments
        voted_comments_score = @comments.includes(:votes).sum(:value)
        voted_posts_score = @posts.includes(:votes).sum(:value)
        @total_vote_score = voted_posts_score + voted_comments_score
    end

    def activate 
        @user = User.find_by(activation_token: params[:activation_token])
        @user.try(:activate!)
        flash[:notice] = "Successfully activated your account!"
        log_in_user!(@user) 
        redirect_to root_url  
    end

    private
    def user_params 
        params.require(:user).permit(:user_name, :password, :email)
    end
end