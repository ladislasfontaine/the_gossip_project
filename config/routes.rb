Rails.application.routes.draw do

  resources :cities, only: [:show]
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]
  resources :gossips do
    resources :comments, except: [:show]
    resources :likes, only: [:create, :destroy]
  end
  

  # get '/gossips/:id', to: 'gossip#show', as: 'gossip'
  # get '/author/:author_id', to: 'user#show', as: 'author'
  get '/team', to: 'team#index'
  get '/contact', to: 'contact#index'
  get '/welcome/:first_name', to: 'welcome#index'

  root 'gossips#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
