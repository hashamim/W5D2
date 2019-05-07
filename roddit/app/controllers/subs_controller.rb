class SubsController < ApplicationController
    before_action :ensure_logged_in, only: [:new,:create,]
    before_action :ensure_moderator, only: [:edit, :update]
    def ensure_moderator
        redirect_to new_session_url unless logged_in? && (current_user == Link.find_by(id: params[:id]).moderator)
    end

    def ensure_logged_in
        redirect_to new_session_url unless logged_in?
    end
    def edit
        render :edit
    end
    def new
        render :new
    end
    def create
        @sub = current_user.subs.new(title: params[:title],description: params[:description])
        if @sub.save
            redirect_to sub_url(@sub)
        else
            render :new
        end
    end
    def show
        if @sub = Sub.find_by(id: params[:id])
            render :show
        # else
        #     redirect_to subs_url
        end
    end
end