class Api::V1::AlbumsController < ApplicationController
    
    # GET /albums
    def index
        @albums = Album.all
        render json: @albums
    end

    def show_songs_by_album
        @has_songs = Album.find_by(name: params[:id]).has_songs
        
        if @has_songs.nil? || @has_songs.empty?
            render json: { error: "No se encontraron canciones para el album: #{params[:id]}" }, status: 400
        else
            @songs = Song.where(id: @has_songs)
            # render json: @songs
            render json: @songs, root: 'data', each_serializer: SongSerializer, adapter: :json
        end
    end
    
end


