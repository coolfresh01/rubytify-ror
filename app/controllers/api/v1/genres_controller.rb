class Api::V1::GenresController < ApplicationController

    def index
        @genre_artists = GenreArtist.all
        render json: @genre_artists
    end

    def random_song
        @genre = GenreArtist.find_by(name: params[:genre_name])
        # render json: @genre
        @artists = Artist.where(id: @genre)
        # render json: @artists
        @albums = Album.where(artist_id: @artists)
        # render json: @albums
        @has_songs = HasSong.where(album_id: @albums)
        #render json: @has_songs
        @songs = Song.where(id: @has_songs)
        # render json: @songs.sample
        render json: @songs.sample, root: 'data', each_serializer: SongSerializer, adapter: :json
    end 
end
