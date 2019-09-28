Rails.application.routes.draw do
  resources :users

 resources :games do
   resources :reviews
 end
 get '/home' => 'users#home'
 get '/collection' => 'games#collection'
 get '/login' => 'sessions#login'
 post '/login' => 'sessions#create'
 post '/logout' => 'sessions#destroy'

get '/reviewed_games' => 'users#reviewed_games'
 root 'welcome#home'

 get '/auth/facebook/callback' => 'sessions#facebook_create'
end
