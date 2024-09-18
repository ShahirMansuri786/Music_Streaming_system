Rails.application.routes.draw do
  resources :users
  resources :songs
  resources :playlists
  resources :song_playlists
  resources :likes
  post 'auth/login' , to: 'authentication#login'
  post 'auth/logout' , to: 'authentication#logout'
end
