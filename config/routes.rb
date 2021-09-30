Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [:show]

  resources :comments, only: [:create]

  resources :instagrams do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create]
  end

  get 'hello/index' => 'hello#index'
  get 'hello/link' => 'hello#link'
  root 'instagrams#index'
  delete 'comments/:id' => 'comments#destroy'
  
end