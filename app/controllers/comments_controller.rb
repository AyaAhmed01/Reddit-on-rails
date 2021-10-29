class CommentsController < ApplicationController
    before_action :require_log_in, except: :show
    def new 
        @comment = Comment.new 
    end

    def create 
        post_id = params[:post_id]
        @comment = Comment.new(author: current_user, content: params[:comment], post_id: post_id)
        if @comment.save 
            redirect_to post_url(post_id)
        else
            flash.now[:errors] = @comment.errors.full_messages
            render :new 
        end
    end

    def show 
        @comment = Comment.find(params[:id])
        # fail
    end
end