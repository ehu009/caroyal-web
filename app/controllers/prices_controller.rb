class PricesController < ApplicationController

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
        end
        redirect_to prices_path, notice: message
    end

    def edit
        @price = Price.find_by_id price_params[:id]
    end

    def update
        message = "Price updated."
        redir = edit_price_path(price_params[:id])
        
        @price = Price.find_by_id price_params[:id]
        if @price.update(price_params)
            redir = prices_path
        else
            message = @price.errors.messages
        end
        redirect_to redir, notice: message
    end

    def destroy
        message = "That price listing does not exist."
        @price = Price.find_by_id price_params[:id]
        if @price.destroy then
            message = "Price listing has been destroyed."
        end
        redirect_to prices_path, notice: message
    end

    private
    
    def price_params
        params.require(:price).permit(:location, :value, :time_recorded)
    end

end