# RSpotify::authenticate("cbe23e7bfd64425aa72bb5ad7226091c", "9175b8a4990648d4981522b2c40bf8f9")

namespace :rubitify do
  namespace :seed do
    desc "Carga lista de artistas desde /db/seeds/artists.yml"
    task load_artists_from_yml: :environment do
      db_seed_artists
    end
  end
end

def db_seed_artists
  path = Rails.root.join('db','seeds','artists.yml')
  puts "Leyendo el archivo: #{path}"
  config = YAML.load_file(path)
  
  artistas = config["artists"]
  artistas.each do |art|
    db_seed_artist(art)
  end
end

# ALMACENA CADA UNO DE LOS ARTISTAS EN LA DB
def db_seed_artist(artist_name)
  s_artists = RSpotify::Artist.search("#{artist_name}")
  
  artist = s_artists.first
  puts "\n\n"
  puts "ARTISTA: #{artist.name}"
  # puts artist.popularity
  # puts artist.id
  # puts artist.uri
  # puts artist.href
  # puts artist.genres
  # puts artist.images.first["url"]
  
  ## GREA LOS ARTISTAS EN LA TABLA
  @artist = Artist.create(
    name: artist.name,
    image: artist.images.first["url"],
    popularity: artist.popularity,
    spotify_url: artist.href,
    spotify_id: artist.id
  )

  @artist.save_genres(artist.genres)

  # CARGA LOS ALBUMS DEL ARTISTA
  albums = artist.albums
  albums.each do |album|
    db_seed_albums(@artist.id, album)
  end
  
end

# ALMACENA CADA UNO DE LOS ALBUNES DE CADA ARTISTA
def db_seed_albums(artist_id, album_element)
  
 @album = Album.create(
    name: album_element.name,
    image: album_element.images.empty? ? "N/A" : album_element.images.first["url"],
    spotify_url: album_element.external_urls["spotify"],
    total_tracks: album_element.total_tracks,
    spotify_id: album_element.id,
    artist_id: artist_id
  )

  puts "      ALBUM:  #{album_element.name}"
  puts "              imagen        -> #{album_element.images.empty? ? "N/A" : album_element.images.first["url"]} "  
  puts "              spotify_url   -> #{album_element.external_urls["spotify"]}"
  puts "              total_tracks  -> #{album_element.total_tracks}"
  puts "              spotify_id    -> #{album_element.id}"

  tracks = album_element.tracks
  tracks.each do |track|
    db_seed_tracks(@album, track)
  end

end

def db_seed_tracks(album, track_element)
  
  @song = Song.create(
    name: track_element.name,
    spotify_url: track_element.external_urls["spotify"],
    preview_url: track_element.preview_url,
    duration_ms: track_element.duration_ms,
    explicit: track_element.explicit,
    spotify_id: track_element.id,
  )

  HasSong.find_or_create_by(album: album, song: @song)

  puts "                  CANCION:      #{track_element.name}"
  puts "                  SPOTIFY_URL:  #{track_element.external_urls["spotify"]} "
  puts "                  PREVIEW_URL:  #{track_element.preview_url}"
  puts "                  DURATION_MS:  #{track_element.duration_ms}"
  puts "                  EXPLICIT:     #{track_element.explicit}"
  puts "                  SPOTIFY_ID:   #{track_element.id}"

end