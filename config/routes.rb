Rails.application.routes.draw do
  root 'pages#home'

  get '/pages/home', to: 'pages#home'

  get '/signup', to: 'chefs#new'
  resources :chefs, except: [:new]
  resources :recipes

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/login', to: 'sessions#destroy'
end
