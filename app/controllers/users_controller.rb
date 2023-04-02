class UsersController < ApplicationController
  layout "application_fishy", only: [:new]

  before_action :must_login, only: [:edit, :update, :change_passwowd, :change_phone, :destroy]
  before_action :must_be_admin, only: [:edit, :update, :change_passwowd, :change_phone, :destroy]


  def new
    @user = User.new
    if session[:create_params].nil? then
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
    if @user.save then
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
    @user = User.find(params[:id])
  end

  def change_pwd
    confirm = false
    message = "Provide a new password."
    redir = edit_user_path(params[:user_id])
    
    @user = User.find(params[:user_id])
    p = params.require(:user).permit(:password, :new_password, :password_confirm)
    unless p[:new_password].nil? then
      message = "New password and confirmation do not match."
      if p[:new_password] == p[:password_confirm] then
        message = "You must provide your current password."
        if p[:password] != nil && @user.authenticate(p[:password]) then
          @user.password = p[:new_password]
          message = "Password successfully updated."
          confirm = true
        end
      end
    end
    if confirm then
      unless @user.save then
        message = @user.errors.messages
      end
    end
    redirect_to redir, notice: message
  end

  def change_phone    
    message = "Provide a new phone number."
    redir = edit_user_path(params[:user_id])

    @user = User.find_by_id params[:user_id]
    p = params.require(:user).permit(:phone_number, :phone_number_confirm, :phone_code)
    unless p[:phone_number].nil? then
      message = "New phone number and confirmation do not match."
      if p[:phone_number] == p[:phone_number_confirm] then
        unless p[:phone_code].nil? then
          @user.phone_code = p[:phone_code]
        end
        @user.phone_number = p[:phone_number]
        message = "Phone number successfully updated."
        confirm = true
      end
    end
    if confirm then
      unless @user.save then
        message = @user.errors.messages
      end
    end
    redirect_to redir, notice: message
  end
    


  def update
    message = "Account information successfully updated."
    redir = edit_user_path(params[:id])
    
    @user = User.find(params[:id])
    unless @user.update user_params then
      message = @user.errors.messages
    end
    redirect_to redir, notice: message
  end

    

  def destroy
    message = "Please confirm account deletion before committing."
    redir = edit_user_path(params[:id])

    if params[:confirm_deletion] == "on" then
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

  def must_login
    if @current_user.nil? then
      redirect_to login_path, notice: "You must log in to do that."
    end
  end

  def must_be_admin
    if @current_user.administrator then
      return
    end
    unless @current_user.id.to_s == params[:id] then
      redirect_to account_overview_path, notice: "Only administrators can do that."
    end
  end

  def regular_params
    params.require(:user).permit(:confirm_deletion, :email, :password, :company_name, :producer, :distributor, :company_address, :tax_identification_number, :name_prefix, :first_name, :last_name, :date_of_birth, :phone_number, :phone_code, :address, :country, :city, :company_city, :company_country)
  end

  def admin_params
    params.require(:user).permit(:confirm_deletion, :administrator, :email, :password, :company_name, :producer, :distributor, :company_address, :tax_identification_number, :name_prefix, :first_name, :last_name, :date_of_birth, :phone_number, :phone_code, :address, :country, :city, :company_city, :company_country)
  end

  def user_params
    c_id = session[:user_id]
    unless c_id.nil? then
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