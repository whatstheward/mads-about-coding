module AdminHelper

    def give_token(admin) 
        JWT.encode({name: admin}, ENV['SECRET'], 'HS256')
    end

   
end
