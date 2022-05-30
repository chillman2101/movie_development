class Film < ApplicationRecord
    belongs_to :genre
    belongs_to :producer
    validates :rating, length: { maximum:1 }, numericality: { less_than_or_equal_to: 5 }
    validates :release_date, length: { maximum:4 }, numericality: true
    validates :title, :release_date, :rating, :genre_id, :producer_id, presence: true
end
