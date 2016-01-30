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

  # Classrooms
  resources :classrooms, shallow: true do
    # Students
    resources :students, except: :index, shallow: true do
      # Albums
      resources :albums, except: :index, shallow: true do
        # Photos
        resources :photos, except: :index
      end
    end
  end  
end
