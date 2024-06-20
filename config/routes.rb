Rails.application.routes.draw do

  get '/musics/count', to: 'musics#count'
  resources :musics

  get '/artists/count', to: 'artists#count'
  get '/artists/all', to: 'artists#all'
  resources :artists

  get '/users/count', to: 'users#count'
  resources :users

  # Login API
  post '/login', to: 'sessions#login'
  post '/register', to: 'sessions#register'

  # Music API for artist
  get '/artists/:id/music', to: 'artists#get_music'

  # CSV import export
  post '/csv', to: 'csv#import'
  get '/csv', to: 'csv#export'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
