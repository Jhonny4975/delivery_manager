# frozen_string_literal: true

Rails.application.routes.draw do
  resources :transporters, only: %i[index show new create edit update]
  resources :vehicles
end
