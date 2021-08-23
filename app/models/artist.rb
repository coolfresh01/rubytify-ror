class Artist < ApplicationRecord
    has_many :albums
    has_many :genreartists

    def save_genres(genres_elements)

        genres_elements.each do |genre|
            GenreArtist.find_or_create_by(artist: self, name: genre)
        end
    end
    
end
