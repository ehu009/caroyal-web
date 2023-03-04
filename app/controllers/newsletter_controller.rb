class NewsletterController < ApplicationController

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
    
end