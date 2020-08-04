Rails.application.routes.draw do

  root 'home#top'
  get 'home/about'

  devise_for :users

  resources :users, only: [:show,:index,:edit,:update] do
  	resource :relationships, only: [:create, :destroy]
  	get :follows, on: :member
  	get :followers, on: :member
  end

  resources :books
end