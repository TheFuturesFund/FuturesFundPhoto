Rails.application.routes.draw do 
  # Root
  root to: "users#dashboard"
  
  # Devise
  devise_for :users, :skip => [:invitation]
  as :user do
    get "/users/invitation/accept" => "devise/invitations#edit", as: "accept_user_invitation"
  end
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
        resources :photos, only: [:new, :edit, :destroy, :update]
        put :add_photos, on: :member
      end
    end
  end  
end
