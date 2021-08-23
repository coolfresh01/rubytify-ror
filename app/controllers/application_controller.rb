require "application_responder"

class ApplicationController < ActionController::API
  self.responder = ApplicationResponder
  include ActionController::MimeResponds
  respond_to :json


    def index
        @tracks = Track.all
        render json: @tracks
    end

    def top_100
        s_tracks = RSpotify::Playlist.find("coolfresh83","03aLchHaqljucMRPz5L8Su").tracks
        @tracks = s_tracks.map do |s_track|
          Track.new_from_spotify_track(s_track)
        end
        render json: @tracks
    end

    def random
        s_tracks = RSpotify::Playlist.browse_featured.first.tracks
        @tracks = s_tracks.map do |s_track|
          Track.new_from_spotify_track(s_track)
        end
        render json: @tracks
    end

    def search
        # Tracks
        # s_tracks = RSpotify::Track.search(params[:q])
        # @tracks = s_tracks.map do |s_track|
        #  Track.new_from_spotify_track(s_track)
        #  puts "explicit: #{s_track.explicit}"
        # end
        # render json: @tracks

        # Artists
        # s_artists = RSpotify::Artist.search(params[:q])
        # artist = s_artists.first
        # albums = artist.albums
        # # render json: albums
        # am = albums
        # puts "Canciones: #{am}"
        # render json: am

        # Albums
        s_tracks = RSpotify::Track.search(params[:q])
        @tracks = s_tracks.map do |s_track|
            Track.new_from_spotify_track(s_track)
        end
        render json: @tracks
    end

end
