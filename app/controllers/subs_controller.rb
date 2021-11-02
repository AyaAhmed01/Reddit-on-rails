class SubsController < ApplicationController
    before_action :require_signed_in!, except: %i(index show)
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
        sub = Sub.friendly.find(params[:id])
        sub.destroy
        redirect_to subs_url
    end

    def subscribe
        sub = Sub.friendly.find(params[:id])
        subscription = sub.subscriptions.new(user: current_user)
        unless subscription.save 
            flash.errors[:error] = subscription.errors.full_messages
        end
        redirect_to sub_url(sub)
    end

    def unsubscribe
        sub = Sub.friendly.find(params[:id])
        subscription = sub.subscriptions.find_by(user: current_user)
        subscription.destroy
        redirect_to sub_url(sub)
    end

    private

    def sub_params
        params.require(:sub).permit(:title, :description)
    end

    def require_moderator
        sub = Sub.friendly.find(params[:id])
        unless sub.moderator == current_user
            flash[:notice] = "Only moderator can edit a sub"
            redirect_to sub_url(sub)
        end
    end
end