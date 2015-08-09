Rails.application.routes.draw do 
  # Root
  root to: 'students#index'
  
  # Devise
  devise_for :users

  # Directors
  resources :directors

  # Teachers
  resources :teachers

  # Students
  resources :students
end
