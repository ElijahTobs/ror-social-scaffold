Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users

  
  resources :users, only: [:index, :show]
  resources :friendships

  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  # get 'invite', to: 'friendships#create'
  # delete 'reject', to: 'friendships#destroy'
  # put 'invite', to: 'friendships#update'

  # post 'invite', to: 'friendship#create'
  

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
