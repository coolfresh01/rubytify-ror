class Api::V1::ArtistsController < ApplicationController
    
    # GET /artists
    def index    
        @artists = Artist.all.order(popularity: :desc)
        @genres = GenreArtist.where(artist_id: @artists)
        
        render json: @artists, root: 'data', each_serializer: ArtistSerializer, adapter: :json
    end
    
    def show
        @artist = Artist.find_by(name: params[:id])
        if @artist.nil?
            render json: { error: "No se encontro artista: #{params[:id]}" }, status: 400
        else
            render json: @artists, root: 'data', each_serializer: ArtistSerializer, adapter: :json
        end
    end

    def show_albums_by_artist
        @artist = Artist.find_by(id: params[:id])
        if @artist.nil?
            render json: { error: "No se encontraron albums para el artista: #{params[:id]}" }, status: 400
        else
            @albums = @artist.albums
            render json: @albums, root: 'data', each_serializer: AlbumSerializer, adapter: :json
        end
    end
    
end
