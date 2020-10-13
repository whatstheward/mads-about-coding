class PostsController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :authenticate, only: [:new, :create, :edit, :update, :delete]

    def index
        @current = params[:page].to_i
        slice_idx = 0
        slice_idx = @current == "1" ? 0 : (@current.to_i-1) * 8 if params[:page].present?
        @posts = Post.where(nil)
        @posts = Post.search_by_keyword(params[:search]) if params[:search].present?
        @posts = Post.search_by_tag(params[:q]) if params[:q].present?
        @page_count = @posts.count % 8 == 0 ? @posts.count/8 : @posts.count/8+1
        @posts = @posts.offset(slice_idx).take(8)
    end

    def show
        @post = Post.find(params[:id])
    end

    def new 
        @post = Post.new
    end

    def create
        @post = Post.new(post_params)
        if @post.save
            @post.add_tags(params[:post][:tag_list])
            redirect_to posts_path
        else
            render :new
        end
    end

    def edit
        @post = Post.find_by!(id: params[:id])
        @tag_list = @post.tag_str
    end

    def update
        @post = Post.find_by!(id: params[:id])
        @post.update(post_params)
        redirect_to post_path(@post)
    end

    def destroy
        Post.find(params[:id]).destroy
        redirect_to posts_path
    end

    private

    def post_params
        params.require(:post).permit(:title, :body)
    end

end
