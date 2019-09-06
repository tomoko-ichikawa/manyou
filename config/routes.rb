Rails.application.routes.draw do

  get 'labels/create'
  get 'labels/destroy'
  resources :tasks do
    collection do
      post :confirm
    end
  end

  resources :users, only:[:new,:create,:show]
  resources :sessions, only: [:new, :create, :destroy]
  resources :labels, only:[:create,:destroy]

  namespace :admin do
    resources :users
    resources :groups
  end

  root to: 'tasks#index'

end
