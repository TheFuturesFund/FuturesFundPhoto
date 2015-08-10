Rails.application.routes.draw do 
  # Root
  root to: 'users#dashboard'
  
  # Devise
  devise_for :users
  resources :users

  # Directors
  resources :directors

  # Teachers
  resources :teachers

  # Users
  resources :users
  get :dashboard, to: 'users#dashboard'

  # Students
  resources :students
end
