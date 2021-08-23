class Song < ApplicationRecord
    has_many :has_songs
    has_many :albums, through: :has_songs
end
