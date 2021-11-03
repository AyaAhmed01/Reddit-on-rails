class UsersController < ApplicationController 
    def create 
        @user = User.new(user_params)
        if @user.save
            log_in_user!(@user)  
            redirect_to subs_url
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

    private
    def user_params 
        params.require(:user).permit(:user_name, :password)
    end
end