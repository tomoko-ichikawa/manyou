Rails.application.routes.draw do
  resources :tasks do
    collection do
      post :confirm
    end
  end
  resources :sessions, only: [:new, :create, :destroy]

  namespace :admin do
    resources :users
  end
end
