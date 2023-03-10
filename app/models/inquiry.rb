class Inquiry < ApplicationRecord

    validates_presence_of :body
    validates_presence_of :email
    
end
