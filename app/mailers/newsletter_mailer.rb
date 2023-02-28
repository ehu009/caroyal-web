class NewsletterMailer < ApplicationMailer

    
    def welcome_newsletter_to user
        
        o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
        @token = (0...25).map { o[rand(o.length)] }.join

        from = Email.new(email: 'newsletter@caroyal.com')
        to = Email.new(email: user.email)
        body = render_to_string(:welcome, layout: 'newsletter_mailer')
        content = Content.new(type: 'text/html', value: body)
  
        mail = SendGrid::Mail.new(from, 'Caroyal newsletter', to, content)
        sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
        response = sg.client.mail._('send').post(request_body: mail.to_json)

        user.unsubscribe_token = @token
        user.save 
  
    end

    def newsletter_to issue_number, user
        
        o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
        @token = (0...25).map { o[rand(o.length)] }.join
        @issue = issue_number

        from = Email.new(email: 'newsletter@caroyal.com')
        to = Email.new(email: user.email)
        body = render_to_string(("newsletter_no" + issue_number.to_s).to_sym, layout: 'newsletter_mailer')
        content = Content.new(type: 'text/html', value: body)
  
        mail = SendGrid::Mail.new(from, 'Caroyal newsletter', to, content)
        sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
        response = sg.client.mail._('send').post(request_body: mail.to_json)

        user.latest_received = issue_number
        user.unsubscribe_token = @token
        user.save

    end

end
