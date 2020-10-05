class PostsController < ApplicationController

    def index
    end

    def filter
        tag = Tag.find_by!(name: params[:q])
        # @posts = Post.left_outer_joins(:tags).where('tag.name' => params[:q])
        byebug
    end

    def show
        @post = Post.find(params[:id])
    end

end
