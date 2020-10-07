class AdminController < ApplicationController
    include AdminHelper
    skip_before_action :verify_authenticity_token

    def login
        
    end

    def create 
        if params[:password] == ENV['HANDSHAKE']
            @token = give_token
            session[:id] = @token 
            redirect_to new_admin_post_path
        else
            redirect_to welcome_path
        end
    end
end
