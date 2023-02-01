class Price < ApplicationRecord
    validates :location, presence: true
    validates :value, presence: true
    validates :time_recorded, presence: true
end
