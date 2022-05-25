# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  resources :transporters, only: %i[index show new create edit update]
  resources :vehicles
end
