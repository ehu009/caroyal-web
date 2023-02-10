class UsersController < ApplicationController
    layout "application_blue", except: [:new]
    layout "application_white", only: [:new]
    
    def new
        @user = User.new
    end

    def stats
        p = User.where(:producer => true)
        d = User.where(:distributor => true)

        render json: [["Producers",p.count()],["Distributors", d.count()]]
    end

    def create

        @user = User.new(regular_params)
        @user.administrator = false
        @user.producer = false
        @user.distributor = false
        if @user.save
            session[:user_id] = @user.id
            redirect_to account_overview_path, notice: "User account was created successfully."
        else
            message = @user.errors.messages
            redirect_to new_user_path, notice: message
        end
    end

    def show
        @user = User.find(params[:id])
    end

    def edit
        allow = false
        message = "You cannot edit account info without first logging in."
        redir = login_path
        
        c_id = session[:user_id]

        if c_id != nil then
            current_user = User.find_by_id c_id
            message = "Only administrators may edit an account they do not own."
            redir = account_overview_path

            if c_id.to_s == params[:id] then
                allow = true
            else
                if current_user.administrator then
                    allow = true                    
                end
            end
                
        end
        if allow == false then
            redirect_to redir, notice: message
        else
            @user = User.find(params[:id])
        end
    end

    def update
        
        allow = false
        message = "You cannot edit account info without first logging in."
        redir = login_path
        
        c_id = session[:user_id]
        current_user = nil

        if c_id != nil then
            current_user = User.find_by_id c_id
            message = "Only administrators may edit an account they do not own."
            redir = edit_user_path(c_id)
            
            if c_id.to_s == params[:id] then
                allow = true
            else
                if current_user.administrator then
                    allow = true                    
                end
            end
                
        end
        if allow == false then
            redirect_to redir, notice: message
        else
            @user = User.find(params[:id])
        end

        redir = edit_user_path(@user.id)
        if allow then
            if @user.update user_params
                message = "Account information successfully updated."
                redir = account_overview_path
            else
                message = @user.errors.messages
            end
        end
        redirect_to redir, notice: message
    end

    def overview

        id = session[:user_id]
        if id == nil then
            redirect_to login_path, notice: "You are not logged in."
        else
          @user = User.find_by_id id            
        end

    end

    def destroy
        allow = false
        message = "You cannot edit account info without first logging in."
        redir = login_path
        
        c_id = session[:user_id]
        current_user = nil

        if c_id != nil then
            message = "Please confirm account deletion before committing."
            redir = edit_user_path(c_id)

            if params[:confirm_deletion] == "on" then
                current_user = User.find_by_id c_id
                message = "Only administrators may edit an account they do not own."
                
                if c_id.to_s == params[:id] then
                    allow = true
                else
                    if current_user.administrator then
                        allow = true                    
                    end
                end
            end
                
        end
        if allow == true then
            @user = User.find(params[:id])
            message = "Account deletion failed."
            
            if @user.destroy then
                session[:user_id] = nil
                message = "Account deletion successful."
                redir = root_path
            end
        end
        redirect_to redir, notice: message
    end


    private

    def regular_params
        params.require(:user).permit(:confirm_deletion, :email, :password, :first_name, :last_name, :company_name, :producer, :distributor)
    end

    def admin_params
        params.require(:user).permit(:confirm_deletion, :administrator, :email, :password, :first_name, :last_name, :company_name, :producer, :distributor)
    end

    def user_params
        c_id = session[:user_id]
        if c_id != nil then
            current_user = User.find_by_id c_id
            unless current_user.administrator then
                regular_params
            else
                admin_params
            end
        end
    end
end