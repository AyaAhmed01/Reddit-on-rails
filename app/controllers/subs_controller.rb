class SubsController < ApplicationController
    before_action :require_log_in, only: %i(new create)
    before_action :require_author, only: %i(edit update destroy)

    def create
        @sub = Sub.new(sub_params)
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
        @sub = Sub.new 
    end

    def update
        @sub = Sub.update_attributes(sub_params)
        if @sub.save 
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
        @sub = Sub.find(params[:id])
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
end