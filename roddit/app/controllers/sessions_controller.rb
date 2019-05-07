class SessionsController < ApplicationController
    def new
        render :new
    end

    def create
        u = User.find_by_credentials(user_params[:username],
                                    user_params[:password])
        if u
            login!(u)
            redirect_to users_url
        else
            flash.now[:errors] = ["Invalid username or password"]
            render :new
        end
    end

    def destroy
        logout!
        redirect_to new_session_url
    end

    def user_params
        params.require(:user).permit(:username,:password )
    end
end