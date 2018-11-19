Rails.application.routes.draw do
  root "#tasks#index"
  resources :tasks, only:[:index, :new, :edit, :show]
end
