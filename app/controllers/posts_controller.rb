class PostsController < ApplicationController

    def index
        @current = params[:page].to_i
        slice_idx = @current == "1" ? 0 : (@current.to_i-1) * 8
        if params[:ids]
            @page_count = params[:ids].length > 8 ? 0 : params[:ids].length/8+1
            @posts = Post.find(params[:ids]).slice(slice_idx, slice_idx+8)
        else
            @page_count = Post.count % 8 == 0 ? Post.count/8 : Post.count/8+1
            @posts = Post.offset(slice_idx).take(8)
        end
    end

    def filter
        @posts = Post.includes(:tags).where(tags:{name:params[:q]})
        redirect_to posts_path(ids:@posts.ids, page: 1)
    end

    def show
        @post = Post.find(params[:id])
    end

    private

end
