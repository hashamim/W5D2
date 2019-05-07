class UsersController < ApplicationController 
    def new
        render :new
    end

    def create
        u = User.new(:username => user_params[:username], password: user_params[:password])
        if u.save
            login!(u)
            redirect_to users_url
        else
            flash.now[:errors] = u.errors.full_messages
            render :new
        end
    end

    private
    def user_params
        params.require(:user).permit(:username,:password )
    end
end
