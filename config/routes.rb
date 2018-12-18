Rails.application.routes.draw do
  devise_for :users

  root 'books#top'

  resources :books, only: [:show, :index, :edit, :update, :create, :destroy]

  resources :users, only: [:show, :index, :edit, :update, :create]

  get '/home/about' => 'homes#about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
