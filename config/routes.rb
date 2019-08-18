Rails.application.routes.draw do

  resources :tasks do
    collection do
      post :confirm
    end
  end

  resources :users, only:[:new,:create,:show]
  resources :sessions, only: [:new, :create, :destroy]

  namespace :admin do
    resources :users
  end

  root to: 'tasks#index'

end
