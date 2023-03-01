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
      NewsletterMailer.welcome_newsletter_to(sub).deliver_now
      message = "Thanks for signing up! We've dispatched a welcome email."
    else
      message = sub.errors.messages
    end
    redirect_to redir, notice: message

  end

  def destroy
    user = NewsletterSubscriber.find(unsub_params)
    message = "Error unsubscriping from newsletter."
    if user != nil then
      user.destroy
      message = "Successfully unsubcribed from newsletter."
    end
    redirect_to root_path, notice: message
  end


  private
  
  def required
    params.require(:newsletter_subscriber)
  end
  
  def sub_params
    required.permit(:email)
  end

  def unsub_params
    required.permit(:unsubscribe_token)
  end

end
