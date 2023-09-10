Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show] 

  resources :users do
    member do
     get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]

  resources :actives do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create]
  end

  
  root 'actives#index'

end
