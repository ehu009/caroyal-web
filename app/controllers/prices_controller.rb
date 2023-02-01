class PricesController < ApplicationController

    def index
        @prices = Price.take(10)
    end

    def new
        @price = Price.new
    end

    def create
        
        @price = Price.new(price_params)
        if @price.save
            message = "Price added."
        else
        end
        redirect_to prices_path
    end

    def edit
        @price = Price.find_by_id price_params[:id]
    end

    def update
        @price = Price.find_by_id price_params[:id]
        if @price.update(price_params)
            redirect_to prices_path, notice: "Price added."
        else
            message = @price.errors.messages
            redirect_to edit_price_path, notice: message
        end
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