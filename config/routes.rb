Rails.application.routes.draw do
  root 'pages#home'
  get '/pages/home', to: 'pages#home'
  get '/signup', to: 'chefs#new'

  resources :chefs, except: [:new]
  resources :recipes do
    resources :comments, only: [:create]
  end

  get '/chat', to: 'chat_rooms#show', as: 'chat'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/login', to: 'sessions#destroy'

  resources :messages, only: [:create]
  resources :ingredients, except: [:destroy]
  mount ActionCable.server => '/cable'
end
