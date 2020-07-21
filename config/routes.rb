Rails.application.routes.draw do
  root 'static_pages#home'
  get    :about,        to: 'static_pages#about'
  get    :use_of_terms, to: 'static_pages#terms'
  get    'signup',      to: 'users#new'
  get    :login,        to: 'sessions#new'
  post   :login,        to: 'sessions#create'
  delete :logout,       to: 'sessions#destroy'
  get    :favorites,    to: 'favorites#index'
  post   "favorites/:course_id/create", to: "favorites#create"
  delete "favorites/:course_id/destroy", to: "favorites#destroy"
  get    :lists,        to: 'lists#index'
  post   "lists/:course_id/create", to: "lists#create"
  delete "lists/:list_id/destroy", to: "lists#destroy"
  get    'search', to: 'courses#search'
  post   '/users/guest_sign_in', to: 'sessions#new_guest'

  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :courses
  resources :relationships, only: [:create, :destroy]
  resources :comments, only: [:create, :destroy]
  resources :notifications, only: :index
  resources :logs, only: [:create, :destroy]
end
