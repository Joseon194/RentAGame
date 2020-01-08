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

match 'auth/github/callback', to: 'sessions#create', via: [:get,:post]
match 'auth/failure', to: redirect('/'), via: [:get, :post]
match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]
#Get is used to fetch data and Post is used for submitting data

get 'auth/google_oauth2/callback', to: 'sessions#googleAuth'
get 'auth/failure', to: redirect('/')
end
