class SubsController < ApplicationController
    before_action :require_signed_in!, only: %i(new create)
    before_action :require_moderator, only: %i(edit update destroy)

    def create
        @sub = current_user.subs.new(sub_params)
        if @sub.save 
            redirect_to sub_url(@sub) 
        else
            flash.now[:errors] = @sub.errors.full_messages
            render :new 
        end
    end

    def new 
        @sub = Sub.new 
    end

    def edit 
        @sub = Sub.friendly.find(params[:id])
    end

    def update        
        @sub = Sub.friendly.find(params[:id])
        if @sub.update(sub_params)
            flash[:success] = "Sub edited!"
            redirect_to sub_url(@sub) 
        else 
            flash.now[:errors] = @sub.errors.full_messages
            render :edit 
        end
    end

    def index  
        @subs = Sub.all  
    end

    def show
        @sub = Sub.friendly.find(params[:id])
        @posts = @sub.posts.includes(:votes)
    end

    def destroy
        sub = Sub.find(params[:id])
        sub.destroy
        redirect_to subs_url
    end

    private

    def sub_params
        params.require(:sub).permit(:title, :description)
    end

    def require_moderator
        sub = Sub.find(params[:id])
        unless sub.moderator == current_user
            flash[:notice] = "Only moderator can edit a sub"
            redirect_to sub_url(sub)
        end
    end
end