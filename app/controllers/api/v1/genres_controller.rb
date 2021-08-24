class Api::V1::GenresController < ApplicationController

    def index
        @genre_artists = GenreArtist.all
        render json: @genre_artists
    end

    def random_song
        @genres = GenreArtist.where(name: params[:genre_name].downcase)
        @artist = @genres.sample
        if @artist.nil?
            render json: { error: "No se encontraron datos para el album: #{params[:genre_name]}" }, status: 400
        else
            @art = Artist.where(id: @artist.artist_id)
            @albums = Album.where(artist_id: @art)
            @has_songs = HasSong.where(album_id: @albums)
            @songs = Song.where(id: @has_songs)
            render json: @songs.sample, root: 'data', each_serializer: SongSerializer, adapter: :json
        end
    end 
end
