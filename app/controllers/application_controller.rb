class ApplicationController < ActionController::Base

    def index
        redirect_to posts_path(page: 1)
    end

end
