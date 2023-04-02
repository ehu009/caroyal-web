class NewsletterController < ApplicationController

  before_action :confirm_admin

  def index
    @newsletters = Newsletter.all
  end

  def new
    @newsletter = Newsletter.new
  end

  def create
    @newsletter = Newsletter.new
  end

  def edit

  end

  def destroy

  end

  def dispatch_latest

  end

  private

  def newsletter_params

  end

  def confirm_admin
    id = session[:user_id]
    
    if !id.nil? then
      user = User.find_by_id id
      if user.administrator == false then
        redirect_to root_path, notice: "Sorry - that page is for administrators."
      end
    end
  end
    
end