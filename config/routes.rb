# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :transporters, only: %i[index show new create edit update] do
    get 'search', on: :collection
  end

  resources :budgets, only: %i[new create]
  resources :deadlines, only: %i[new create]
  resources :vehicles

  get '/welcome' => 'welcome#index', as: :user_root
end
