class NewsletterArticle < ApplicationRecord

    validates :issue_number, uniqueness: true

end
