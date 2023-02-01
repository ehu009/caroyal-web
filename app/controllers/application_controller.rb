class ApplicationController < ActionController::Base

    def home

    end

    def dev
        @users = User.take
    end


end
