module AdminHelper

    def give_token 
        JWT.encode({phrase: 'great_jorb'}, ENV['SECRET'], 'HS256')
    end
end
