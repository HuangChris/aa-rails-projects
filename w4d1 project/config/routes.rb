Rails.application.routes.draw do
  resources :users, only: [:create, :destroy, :index, :show, :update] do
    resources :contacts, only: [:index]
    resources :comments, only: [:index, :create]
    get :favorites, on: :member
  end

  resources :contacts, only: [:create, :destroy, :show, :update] do
    resources :comments, only: [:index, :create]
  end

  resources :contact_shares, only: [:create, :destroy]
  resources :comments, only: [:destroy]
end
