# frozen_string_literal: true

Rails.application.routes.draw do
  get 'groups/index'
  root 'tasks#index'
  resources :tasks
  resources :users, only: %i[new create show]
  resources :sessions, only: %i[new create destroy]
  resources :labels, only: %i[new create destroy]
  resources :groups do
    resources :assigns, only: %i[create destroy]
  end
  get 'search', to: 'tasks#search'

  namespace :admin do
    resources :users
  end
end
