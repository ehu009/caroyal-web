class SessionsController < ApplicationController

    def create
        @user = User.find_by(email: params[:email])

        if !!@user && @user.authenticate(params[:password])

            session[:user_id] = @user.id
            redirect_to account_overview_path

        else
            message = "Error logging in."
            redirect_to login_path, notice: message
            
        end
    end

    def destroy

        if session[:user_id] != nil then
            session[:user_id] = nil
            
        else
            
        end

        redirect_to login_path

    end


end