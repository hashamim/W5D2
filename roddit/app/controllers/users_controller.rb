def new
    render :new
end

def create
    u = User.new(:username => user_params[:username], password: user_params[:password])
    if u.save
        #redirect somewhere
    else
        flash.now[:errors] = u.errors.full_messages
        render :new
end

private
def user_params.require(:user).permit(:username,:password )
    params
end
