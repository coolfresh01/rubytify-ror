Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  Rails.application.routes.draw do
    namespace :api do
      namespace :v1 do
        resources :artists, defaults: {format: 'json'} do
          collection do
            get ":id/albums", to: "artists#show_albums_by_artist" 
          end
        end
        resources :albums do
          collection do
            get ":id/songs", to: "albums#show_songs_by_album" 
          end
        end
        resources :genres do
          collection do
            get ":genre_name/random_song", to: "genres#random_song"
          end
        end
        resources :tracks do
          collection do
            get :top_100
            get :random
            get :search
          end
        end
      end
    end
  end
  
end
