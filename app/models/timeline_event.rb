class TimelineEvent < ApplicationRecord
    validates :number, uniqueness: true
end
