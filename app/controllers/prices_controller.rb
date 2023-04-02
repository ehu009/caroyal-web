class PricesController < ApplicationController
    
  before_action :confirm_admin, except: [:price_data]

  def index
    @prices = Price.take(10)
  end

  def new
    @price = Price.new
  end

  def create
    message = ""
    @price = Price.new(price_params)
    if @price.save
      message = "Price added."
    else
      message = "Error creating new price."
    end
    redirect_to prices_path, notice: message
  end

  def edit
    @price = Price.find_by_id params[:id]
  end

  def update
    message = "Price updated."
    redir = edit_price_path(params[:id])
        
    @price = Price.find_by_id params[:id]
    if @price.update(price_params)
      redir = prices_path
    else
      message = @price.errors.messages
    end
    redirect_to redir, notice: message
  end
  
  def date_and_price_list(location)
    Price.where(:location => location).map do |x|
      [x[:time_recorded], x[:value]]
    end
  end
  
  def price_data
      
    l = Price.all.select(:location).distinct
    m = l.map do |x|
      { :name => x[:location], :data => date_and_price_list(x[:location]) }
    end
    render json: m

  end

  def destroy
    message = "That price listing does not exist."
    @price = Price.find_by_id params[:id]
    if @price.destroy then
      message = "Price listing has been destroyed."
    end
    redirect_to prices_path, notice: message
  end

  private
  
  def price_params
      params.require(:price).permit(:location, :value, :time_recorded)
  end

  def confirm_admin
    id = session[:user_id]
    
    if !id.nil? then
      user = User.find_by_id id
      unless user.administrator then
        redirect_to root_path, notice: "Sorry - that page is for administrators."
      end
    end
  end

end