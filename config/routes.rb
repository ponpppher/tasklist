# frozen_string_literal: true

Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks
  resources :users, only: %i[new create show]
  resources :sessions, only: %i[new create destroy]
  resources :labels, only: %i[new create destroy]
  get 'search', to: 'tasks#search'

  namespace :admin do
    resources :users
  end
end
