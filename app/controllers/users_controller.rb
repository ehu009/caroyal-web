class UsersController < ApplicationController
  layout "application_fishy", only: [:new]

  def new
    @user = User.new
    if session[:create_params] == nil then
      session[:create_params] = {}
    end
  end

  def stats
    p = User.where(:producer => true)
    d = User.where(:distributor => true)

    render json: [["Producers",p.count()],["Distributors", d.count()]]
  end

  def create

    @user = User.new(user_params)
    @user.administrator = false
    session[:create_params] = {}
    message = "User account was created successfully."
    redir = new_user_path
    if @user.save
      session[:user_id] = @user.id
      session[:create_params] = nil
      email = false
      if @user.email != "" && @user.email != nil then
        #NoReplyMailer.email_confirmation(@user).send_now
        #message += "<br>We've sent you an email so that you may confirm your email address."
      end
      redir = first_time_login_path
    else
      remember_create_params
      message = @user.errors.messages
    end
    redirect_to redir, notice: message
  end

  def show
    @user = User.find(params[:user_id])
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

  def change_pwd       
    allow = false
    message = "You cannot edit account info without first logging in."
    redir = login_path
    
    c_id = session[:user_id]
    current_user = nil

    if c_id != nil then
      current_user = User.find_by_id c_id
      message = "Only administrators may edit an account they do not own."
      redir = edit_user_path(c_id)
      
      if c_id.to_s == params[:user_id] then
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
      @user = User.find(params[:user_id])
    end

    redir = edit_user_path(@user.id)
    if allow then
      p = params.require(:user).permit(:password, :new_password, :password_confirm)
      message = "Provide a new password."
      if p[:new_password] != nil then
        allow = false
        message = "New password and confirmation do not match."
        if p[:new_password] == p[:password_confirm]
          message = "You must provide your current password."
          if p[:password] != nil && @user.authenticate(p[:password]) != false then
            @user.password = p[:new_password]
            message = "Password successfully updated."
            allow = true
          end
        end
      end
      if allow then
        if @user.save
          redir = account_overview_path
        else
          message = @user.errors.messages
        end
      end
    end
    redirect_to redir, notice: message
  end

  def change_phone
    allow = false
    message = "You cannot edit account info without first logging in."
    redir = login_path
    
    c_id = session[:user_id]
    current_user = nil

    if c_id != nil then
      current_user = User.find_by_id c_id
      message = "Only administrators may edit an account they do not own."
      redir = edit_user_path(c_id)
      if c_id.to_s == params[:user_id] then
          allow = true
      else
        if current_user.administrator then
          allow = true                    
        end
      end
    end
    if allow == false then
      puts "niggers"
      redirect_to redir, notice: message
      return
    else
      @user = User.find(params[:user_id])

    end

    redir = edit_user_path(@user.id)
    if allow then
      message = "Provide a new phone number."
      p = params.require(:user).permit(:phone_number, :phone_number_confirm, :phone_code)
      if p[:phone_number] != nil then
        allow = false
        message = "New phone number and confirmation do not match."
        if p[:phone_number] == p[:phone_number_confirm]
            
          if p[:phone_code] != nil then
            current_user.phone_code = p[:phone_code]
          end
          @user.phone_number = p[:phone_number]
          
          message = "Phone number successfully updated."
          allow = true
        end
      end
      if allow then
          if @user.save
            redir = account_overview_path
          else
            message = @user.errors.messages
          end
      end
    end
    redirect_to redir, notice: message
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
    params.require(:user).permit(:confirm_deletion, :email, :password, :company_name, :producer, :distributor, :company_address, :tax_identification_number, :name_prefix, :first_name, :last_name, :date_of_birth, :phone_number, :phone_code, :address, :country, :city, :company_city, :company_country)
  end

  def admin_params
    params.require(:user).permit(:confirm_deletion, :administrator, :email, :password, :company_name, :producer, :distributor, :company_address, :tax_identification_number, :name_prefix, :first_name, :last_name, :date_of_birth, :phone_number, :phone_code, :address, :country, :city, :company_city, :company_country)
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
    else
      regular_params
    end
  end

  def remember_create_params
    session[:create_params] = params[:user]
    session[:create_params]['password'] = ""
    def set_checkmark key
      v = false
      if session[:create_params][key] == "1" then
        v = true
      end
      session[:create_params][key] = v
    end
    set_checkmark 'producer'
    set_checkmark 'distributor'
  end
end