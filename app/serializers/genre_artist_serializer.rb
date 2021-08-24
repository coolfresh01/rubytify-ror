class GenreArtistSerializer < ActiveModel::Serializer
  attributes :name, :artist_id
  belongs_to :artist
end
