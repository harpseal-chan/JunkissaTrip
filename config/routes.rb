Rails.application.routes.draw do
  get 'sessions/new'
  root 'static_pages#home'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  post '/guest_login', to: 'guest_sessions#create'
  resources :users, except: [:index]
  resources :shops, only: [:index, :show] do
    resource :bookmarks, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
end
