class PostsController < ApplicationController 
    before_action :require_log_in, only: %i(new create)
    before_action :require_author, only: %i(edit update destroy)

    def create
        @post = Post.new(post_params)
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
        @post = Post.new  
    end

    def update
        @post = Post.update_attributes(post_params)
        if @post.save 
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
        @post = Post.find(params[:id])
    end
    
    private
    def post_params
        params.require(:post).permit(:title, :content, :url, sub_ids:[])
    end

    def require_author
        post = Post.find(params[:id])
        redirect_to post_url(post) unless post.author == current_user
    end
end