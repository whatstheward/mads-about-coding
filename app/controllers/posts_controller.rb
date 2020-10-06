class PostsController < ApplicationController

    def index
        if params[:ids]
            @posts = Post.find(params[:ids])
        else
            @posts = Post.all
        end
    end

    def filter
        @posts = Post.includes(:tags).where(tags:{name:params[:q]})
        redirect_to posts_path(ids:@posts.ids)
    end

    def show
        @post = Post.find(params[:id])
    end

end
