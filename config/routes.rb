Rails.application.routes.draw do
  root "tasks#index"
  resources :tasks 
  resources :users, only:[:new, :create, :show]
  resources :sessions, only:[:new, :create, :destroy]
  resources :labels, only:[:index, :destroy]

  namespace :admin do
    resources :users
  end
end
