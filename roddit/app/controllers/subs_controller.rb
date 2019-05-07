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
end