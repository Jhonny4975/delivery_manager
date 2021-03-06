# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :transporters, only: %i[index show new create edit update]
  resources :budgets, only: %i[new create]
  resources :deadlines, only: %i[new create]
  resources :vehicles

  resources :service_orders, only: %i[index create show edit update] do
    get 'search', on: :collection
    get 'tracking', on: :collection
  end

  get '/welcome' => 'welcome#index', as: :user_root
end
