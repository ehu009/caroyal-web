class UsersController < ApplicationController

    def new
        @user = User.new
    end

    def create

        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to root_path
        else
            
        end
    end

    def show
        @user = User.find(params[:id])
    end

    def overview
        id = session[:user_id]
        if id == nil then
            redirect_to login_path
        else
          @user = User.find_by_id id            
        end


    end

    private

    def user_params
        params.require(:user).permit(:email, :password)
    end
end