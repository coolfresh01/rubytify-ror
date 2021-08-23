class ArtistSerializer < ActiveModel::Serializer
  attributes :id, :name, :image, :spotify_url
  # has_many :genre_artists
  # class GenreArtistSerializer < ActiveModel::Serializer
  #   attributes :name
  # end
end
