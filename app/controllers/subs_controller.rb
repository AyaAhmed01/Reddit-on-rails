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
        @sub = find_sub_by_id
    end

    def update        
        @sub = find_sub_by_id
        if @sub.update(sub_params)
            flash[:notice] = ["Sub edited!"]
            redirect_to sub_url(@sub) 
        else 
            flash.now[:errors] = @sub.errors.full_messages
            render :edit 
        end
    end

    def index 
        if params[:sub]       # for search
            @subs = Sub.all.where("lower(title) LIKE ?", "%#{sub_params[:title].downcase}%")
        else
            if current_user   # show only subscribed in subs if user logged in
                @subs = current_user.subscribed_subs
            else
                @subs = Sub.all  # show all subs if user is not logged in
            end
        end 
    end

    def show
        @sub = find_sub_by_id
        @posts = @sub.posts.includes(:votes)
    end

    def destroy
        sub = find_sub_by_id
        sub.destroy
        redirect_to subs_url
    end

    def subscribe
        sub = find_sub_by_id
        subscription = sub.subscriptions.new(user: current_user)
        unless subscription.save 
            flash[:error] = subscription.errors.full_messages
        end
        redirect_to sub_url(sub)
    end

    def unsubscribe
        sub = find_sub_by_id
        subscription = sub.subscriptions.find_by(user: current_user)
        subscription.destroy
        redirect_to sub_url(sub)
    end

    private

    def sub_params
        params.require(:sub).permit(:title, :description)
    end

    def require_moderator
        sub = find_sub_by_id
        unless sub.moderator == current_user
           render json: "Forbidden", status: :forbidden 
        end
    end

    def find_sub_by_id
        Sub.friendly.find(params[:id]) 
    end

end