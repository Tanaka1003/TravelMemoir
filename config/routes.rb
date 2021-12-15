Rails.application.routes.draw do
  get 'relationships/create'
  get 'relationships/destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  root 'homes#top'
  resources :users, only: [:show, :edit, :update] do
  end
  resources :posts, only: [:index, :show, :new, :create, :destroy] do
    resources :tags, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy]
    resources :posts, only: [:create, :destroy]
  end
end
