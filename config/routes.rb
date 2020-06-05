Rails.application.routes.draw do
  root 'static_pages#home'
  get    :about,        to: 'static_pages#about'
  get    :use_of_terms, to: 'static_pages#terms'
  get    'signup',      to: 'users#new'
  get    :login,        to: 'sessions#new'
  post   :login,        to: 'sessions#create'
  delete :logout,       to: 'sessions#destroy'
  get    :favorites,    to: 'favorites#index'
  post   "favorites/:course_id/create" => "favorites#create"
  delete "favorites/:course_id/destroy" => "favorites#destroy"

  resources :relationships, only: [:create, :destroy]
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :courses
  resources :comments, only: [:create, :destroy]
end
