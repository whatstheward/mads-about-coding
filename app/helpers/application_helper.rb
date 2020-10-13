module ApplicationHelper

    def get_posts
        Post.all
    end

    def get_tags
        Tag.tag_counts
    end

    def get_token
        session[:id]
    end

end
