class NewsletterSubscriberController < ApplicationController

  def new
    
    @sub = NewsletterSubscriber.new
    render :new, layout: "application_fishy"
  end

  def create
    sub = NewsletterSubscriber.new sub_params
    sub.latest_received = 0

    message = "Something went wrong."
    redir = root_path
    if sub.save then
      NewsletterMailer.welcome_newsletter_to(sub.email).deliver_now
      message = "Thanks for signing up to our newsletter! We've dispatched a welcome email."
    else
      message = sub.errors.messages
    end
    redirect_to redir, notice: message

  end

  def destroy
    user = NewsletterSubscriber.find_by(unsubscribe_token: params[:unsubscribe_token])
    message = "Error unsubscriping from newsletter."
    if user != nil then
      user.destroy
      message = "Successfully unsubcribed from newsletter."
    end
    redirect_to root_path, notice: message
  end


  private
  
  def sub_params
    params.require(:newsletter_subscriber).permit(:email)
  end

end
