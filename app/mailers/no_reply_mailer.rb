class NoReplyMailer < ApplicationMailer

    def email_confirmation user
      o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
      @token = (0...25).map { o[rand(o.length)] }.join

      from = Email.new(email: 'no-reply@caroyal.com')
      to = Email.new(email: user.email)
      content = Content.new(type: 'text/html', value: render_to_string(:email_confirmation))

      mail = SendGrid::Mail.new(from, 'Confirm you email address', to, content)
      sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
      response = sg.client.mail._('send').post(request_body: mail.to_json)

      user.confirmation_sent_at = Time.now()
      user.confirmation_token = @token
      user.save

    end

    def password_reset email_addr, token
      @token = token
      from = Email.new(email: 'no-reply@caroyal.com')
      to = Email.new(email: email_addr)
      content = Content.new(type: 'text/html', value: render_to_string(:password_reset))

      mail = SendGrid::Mail.new(from, 'Password reset', to, content)
      sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
      response = sg.client.mail._('send').post(request_body: mail.to_json)
    end

end
