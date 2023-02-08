class NoReplyMailer < ApplicationMailer
    default from: email_address_with_name('no-reply@caroyal.no', "no-reply")

    def email_confirm
      @user = params[:user]
      puts @user.email
      #@url  = 'http://example.com/login'
      mail(to: @user.email, subject: 'Welcome to My Awesome Site') #do |m|
      #  m.html { render 'email_confirm' }
      #  m.text { render plain: 'email_confirm yo'}
      #end
    end

end
