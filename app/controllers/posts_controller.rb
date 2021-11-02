class PostsController < ApplicationController 
    before_action :require_signed_in!, only: %i(new create)
    before_action :require_author!, only: %i(edit update destroy)

    def create
        @post = Post.new(post_params)
        @post.author = current_user 
        if @post.save 
            redirect_to post_url(@post) 
        else
            flash.now[:errors] = @post.errors.full_messages
            render :new 
        end
    end

    def new
        @post = Post.new  
    end

    def edit
        @post = Post.friendly.find(params[:id]) 
    end

    def update
        @post = Post.friendly.find(params[:id])
        if @post.update(post_params)
            redirect_to post_url(@post) 
        else
            flash.now[:errors] = @post.errors.full_messages
            render :edit 
        end
    end

    def destroy
        post = Post.find(params[:id])
        post_sub = post.sub 
        post.destroy
        redirect_to sub_url(post_sub)
    end

    def show
        @post = Post.friendly.find(params[:id])
        @all_comments = @post.comments_by_parent_id
    end
    
    def upvote 
        vote(1)
    end

    def downvote
        vote(-1)
    end

    private
    def post_params
        params.require(:post).permit(:title, :content, :url, sub_ids:[])
    end

    def require_author
        post = Post.find(params[:id])
        redirect_to post_url(post) unless post.author == current_user
    end

    def vote(vote_value)
        @post = Post.find(params[:id])
        @user_vote = @post.votes.find_or_initialize_by(user_id: current_user.id)
        @user_vote.update(value: vote_value)
        redirect_to post_url(@post) 
    end
end