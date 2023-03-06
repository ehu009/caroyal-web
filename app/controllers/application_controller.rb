class ApplicationController < ActionController::Base
    
    layout "application"

    before_action :get_current_user
    before_action :must_login, only: [:account_overview, :first_time_login, :new_producer_questionaire, :new_distributor_questionaire, :fill_producer_questionaire, :fill_distributor_questionaire]

    def home
        @sub = NewsletterSubscriber.new
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
        if @user != nil then
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

    def first_time_login
        @user = @current_user
    end

    def new_producer_questionaire
        @prod_q = ProducerQuestionaire.new
    end
    def new_distributor_questionaire
        @dist_q = DistributorQuestionaire.new
    end

    def fill_producer_questionaire        
        message = nil
        redir = new_producer_questionaire_path
        failure = false
        @prod_q = ProducerQuestionaire.new(producer_params)
        @prod_q.user = @current_user
        unless @prod_q.save
            message = @prod_q.errors.messages
            @prod_q = nil
            failure = true
        end
        unless failure == true then
            if @current_user.distributor == true then
                redir =  new_distributor_questionaire_path
            else
                message = "Thanks for taking the time to fill out our questionaire."
            end
        end
        redirect_to redir, notice: message
    end

    def fill_distributor_questionaire
        
        failure = false
        message = nil
        redir = new_distributor_questionaire_path
        @dist_q = DistributorQuestionaire.new(distributor_params)
        @dist_q.user = @current_user
        
        unless @dist_q.save
            message = @dist_q.errors.messages
            failure = true
            @dist_q = nil
        end
        if failure == false then
            message = "Thanks for taking the time to fill out our questionaire."
            redir = account_overview_path
        end
        redirect_to redir, notice: message
    end

    def account_overview

        if @current_user == nil then
            redirect_to login_path, notice: "You are not logged in."
        else
          @user = @current_user
          
          if @user.producer == true then
            @prod_q = ProducerQuestionaire.where(user: @current_user)
          end
          if @user.distributor == true then
            @dist_q = DistributorQuestionaire.where(user: @current_user)
          end
        end

    end

    private
    def get_current_user
        @current_user ||= User.find_by_id(session[:user_id]) if !!session[:user_id]
    end

    def must_login
        if @current_user == nil then
            redirect_to '/login', notice: "You are not logged in."
        end
    end

    def producer_params
        params.require(:producer_questionaire).permit(:commodities, :volume, :pays_deposit, :pays_wire, :pays_card, :pays_crypto, :unit)
    end

    def distributor_params
        params.require(:distributor_questionaire).permit(:length, :yearly_amount, :other_products, :pays_deposit, :pays_wire, :pays_card, :pays_crypto, :unit)
    end

end
