class AdminController < ApplicationController
    include AdminHelper
    skip_before_action :verify_authenticity_token

    def login
        
    end

    def create
        @admin = Admin.find_by!(name: params[:name]) 
        byebug
        if @admin.authenticate(params[:password])
            @token = give_token(@admin.name)
            session[:id] = @token 
            redirect_to new_admin_post_path
        else
            redirect_to welcome_path
        end
    end
end
