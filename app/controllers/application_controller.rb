class ApplicationController < ActionController::Base
    
    layout "application_white", only: [:home]
    before_action :get_current_user

    def home

    end

    def dev
        @users = User.all
    end

    def about
        
    end

    def contact

    end

    def products

    end

    def account_overview

        if @current_user == nil then
            redirect_to login_path, notice: "You are not logged in."
        else
          @user = @current_user
        end

    end

    private
    def get_current_user
        @current_user ||= User.find_by_id(session[:user_id]) if !!session[:user_id]
    end


end
