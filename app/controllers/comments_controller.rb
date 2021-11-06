class CommentsController < ApplicationController
    before_action :require_signed_in!, except: :show
    
    def new 
        @post = Post.friendly.find(params[:post_id])
        @comment = Comment.new(post: @post)  # the top level comment
    end

    def create 
        @comment = current_user.comments.new(comment_params)
        if @comment.save 
            redirect_to post_url(@comment.post_id)
        else 
            flash.now[:errors] = @comment.errors.full_messages
            redirect_to new_post_comment_url(@comment.post_id)
        end
    end

    def show 
        @comment = Comment.find(params[:id])
        @child_comment = @comment.child_comments.new
    end

    def upvote 
        vote(1)
    end

    def downvote
        vote(-1)
    end

    private
    def comment_params
        params.require(:comment).permit(:content, :post_id, :parent_comment_id)
    end

    def vote(vote_value)
        @comment = Comment.find(params[:id])
        @user_vote = @comment.votes.find_or_initialize_by(user_id: current_user.id)
        @user_vote.update(value: vote_value)
        redirect_to comment_url(@comment) 
    end
end