class NewsletterMailer < ApplicationMailer

    
    def welcome_newsletter_to user_mail
        
        o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
        @token = (0...25).map { o[rand(o.length)] }.join
        
        @s = NewsletterSubscriber.find_by email: user_mail
        @s.unsubscribe_token = @token
        @s.save 

        from = Email.new(email: 'newsletter@caroyal.com')
        to = Email.new(email: user_mail)
        body = render_to_string(:welcome, layout: 'newsletter_mailer')
        content = Content.new(type: 'text/html', value: body)
  
        mail = SendGrid::Mail.new(from, 'Caroyal newsletter', to, content)
        sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
        response = sg.client.mail._('send').post(request_body: mail.to_json)

        
  
    end

    def newsletter_to issue_number, user_mail
        
        o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
        @token = (0...25).map { o[rand(o.length)] }.join
        @issue = issue_number

        @s = NewsletterSubscriber.find_by email: user_mail
        @s.latest_received = issue_number
        @s.unsubscribe_token = @token
        @s.save

        from = Email.new(email: 'newsletter@caroyal.com')
        to = Email.new(email: user_mail)
        body = render_to_string(("newsletter_no" + issue_number.to_s).to_sym, layout: 'newsletter_mailer')
        content = Content.new(type: 'text/html', value: body)
  
        mail = SendGrid::Mail.new(from, 'Caroyal newsletter', to, content)
        sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
        response = sg.client.mail._('send').post(request_body: mail.to_json)

    end

end
