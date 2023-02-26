class User < ApplicationRecord

    has_secure_password
    validates :password_digest, presence: true

    validates :phone_code, presence: true
    validates :phone_number, presence: true, uniqueness: { scope: [:phone_code] } 
    validate :check_email

    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :name_prefix, presence: true

    validates :company_name, presence: true
    validates :company_address, presence: true
    validates :company_country, presence: true
    validates :company_city, presence: true
    validates :tax_identification_number, presence: true
    

    has_one :distributor_questionare
    has_one :producer_questionare

    protected
    def check_email
        unless email.blank?
         validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP
        end
    end
end
