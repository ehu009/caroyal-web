class User < ApplicationRecord
    has_secure_password
    validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP
    validates :password_digest, presence: true

    validates :company_name, presence: true
    validates :company_address, presence: true
    validates :tax_identification_number, presence: true
    validates :name_prefix, presence: true
    validates :phone_number, uniqueness: true, presence: true
    validates :country, presence: true
    validates :city, presence: true

    has_one :distributor_questionare
    has_one :producer_questionare

end
