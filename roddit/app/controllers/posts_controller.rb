class PostsController < ApplicationController
    before_action :ensure_logged_in, only: [:new, :create]
    before_action :ensure_author, only: [:edit, :update]
    def ensure_logged_in
        redirect_to new_session_url unless logged_in?
    end

    def ensure_author
        redirect_to new_session_url unless logged_in? && current_user == Post.find_by(id: params[:id]).author
    end
    def new
        render :new
    end

    def create
        @post = current_user.posts.new(title: params[:title], url: params[:url], content: params[:content])
        @post.sub_id = params[:sub_id]
        if @post.save
            redirect_to sub_post_url(@post.sub,@post)
        else
            flash.now[:errors] = @post.errors.full_message
            render :new
        end

    end

    def show
        @post = Post.find_by(id: params[:id])
        render :show
    end
    
    def edit
        @post = Post.find_by(id: params[:id])
        render :edit
    end

    def update
        @post = Post.find_by(id: params[:id])
        @post.title = params[:title]
        @post.url = params[:url]
        @post.content = params[:content]
        if @post.save
            redirect_to sub_post_url(@post.sub,@post)
        else
            flash.now[:errors] = @post.errors.full_message
            render :edit
        end
    end
end
# == Schema Information
#
# Table name: posts
#
#  id        :bigint           not null, primary key
#  title     :string           not null
#  url       :string
#  content   :text
#  sub_id    :integer          not null
#  author_id :integer          not null