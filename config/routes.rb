Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users

  
  resources :users, only: [:index, :show]
  resources :friendships do
    
  end

  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  get 'invite', to: 'friendships#create'

  put 'invite', to: 'users#update'
  # post 'invite', to: 'friendship#create'
  delete 'reject', to: 'users#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
