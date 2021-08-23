class Album < ApplicationRecord

    belongs_to :artist

    has_many :has_songs
    has_many :songs, through: :has_songs
end
