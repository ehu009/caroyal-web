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


end