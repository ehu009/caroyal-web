class UsersController < ApplicationController

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to root_path, notice: "User account was created successfully."
        else
            message = @user.errors.messages
            redirect_to new_user_path, notice: message
        end
    end

    def show
        @user = User.find(params[:id])
    end

    def overview

        id = session[:user_id]
        if id == nil then
            redirect_to login_path, notice: "You are not logged in."
        else
          @user = User.find_by_id id            
        end

    end

    private

    def user_params
        params.require(:user).permit(:email, :password)
    end
end