class PostsController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :authenticate, only: [:new]

    def index
        @current = params[:page].to_i
        slice_idx = 0
        slice_idx = @current == "1" ? 0 : (@current.to_i-1) * 8 if params[:page].present?
            @posts = Post.where(nil)
            @page_count = Post.count % 8 == 0 ? Post.count/8 : Post.count/8+1
            @posts = Post.offset(slice_idx).take(8)
            @page_count = params[:ids].length > 8 ? 0 : params[:ids].length/8+1  if params[:ids].present?
            @posts = Post.find(params[:ids]).slice(slice_idx, slice_idx+8) if params[:ids].present?
            @posts = Post.search_by_keyword(params[:search]) if params[:search].present?
            @page_count = @posts.count % 8 == 0 ? @posts.count/8 : @posts.count/8+1 if params[:search].present?
    end

    def filter
        @posts = Post.includes(:tags).where(tags:{name:params[:q]})
        redirect_to posts_path(ids:@posts.ids, page: 1)
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
            @post.add_tags(params[:post][:tags])
            redirect_to posts_path
        else
            render :new
        end
    end

    private

    def post_params
        params.require(:post).permit(:title, :body)
    end

end
