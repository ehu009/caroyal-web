class ApplicationController < ActionController::Base
    
  layout "application"

  before_action :get_current_user
  before_action :must_login, only: [:account_overview, :first_time_login, :new_producer_questionaire, :new_distributor_questionaire, :fill_producer_questionaire, :fill_distributor_questionaire]

  def home
    @sub = NewsletterSubscriber.new
    if !(@current_user.nil? || !@current_user.email.nil?) then
      s = NewsletterSubscriber.find_by email: @current_user.email
      if !s.nil? then
        @sub = s
      end
    end
    render layout: "application_white"
  end

  def dev
    @users = User.all
    @sub = NewsletterSubscriber.new
    @subs = NewsletterSubscriber.all
  end

  def about
    render layout: "application_white"
  end

  def contact
    @inq = Inquiry.new
    render :contact, layout: "application_fishy"
  end

  def products

  end

  def privacy_policy
    render layout: "application_white"
  end

  def timeline
    @events = TimelineEvent.all.order :number
    render layout: "application_white"
  end

  def confirm_email
    @user = User.find_by confirmation_token: params[:token]
    message = "Found no user with this confirmation token"
    redir = root_path
    if !@user.nil? then
      time = Time.now
      @user.confirmation_token = nil
      message = "Your email confirmation link has expired.<br>We've dispatched another one to your email address."
      if ((time - @user.confirmation_sent_at).to_i / (60*60)) > 15 then
        NoReplyMailer.email_confirmation(@user).send_now
      else
        @user.confirmed_at = time
        message = "You email address has been confirmed."
      end
      @user.save
      @current_user = @user
      redir = account_overview_path
    end
    redirect_to redir, notice: message
  end


  private
  def get_current_user
    @current_user ||= User.find_by_id(session[:user_id]) if !!session[:user_id]
  end

  def must_login
    if @current_user.nil? then
      redirect_to '/login', notice: "You are not logged in."
    end
  end


end
