Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  root 'homes#top'
  resources :users, only: [:show, :edit, :update] do
  end
  resources :posts do
    resources :tags, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy]
  end
end
