class SessionsController < ApplicationController
    layout "application_fishy"
    def create
        message = "Error logging in."
        
        login = params[:string]
        @user = User.find_by(phone_number: login)
        if @user.nil? then
            @user = User.find_by(email: login)
        end

        if !!@user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            message = "Login successful."
            redirect_to account_overview_path, notice: message

        else
            redirect_to login_path, notice: message
            
        end
    end

    def destroy
        message = "You were not logged in."
        if session[:user_id] != nil then
            session[:user_id] = nil
            message = "Sucessfully logged out."
        end

        redirect_to login_path, notice: message

    end


end