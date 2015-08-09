Rails.application.routes.draw do
  # Directors
  resources :directors

  # Teachers
  resources :teachers

  # Students
  resources :students
end
