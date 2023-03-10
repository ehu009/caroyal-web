class NewsletterSubscriber < ApplicationRecord

    validates :email, uniqueness: true
    validate :check_email

    protected
    def check_email
        unless email.blank?
         validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP
        end
    end

end
