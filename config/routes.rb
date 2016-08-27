Rails.application.routes.draw do
  # Root
  root to: "users#dashboard"

  # Devise
  devise_for :users, skip: [:invitations]
  as :user do
    get "/users/invitation/accept" => "devise/invitations#edit", as: :accept_user_invitation
    post "/users/invitation" => "devise/invitations#create", as: :user_invitation
    put "/users/invitation" => "devise/invitations#update", as: :new_user_invitation
  end

  # Directors
  resources :directors

  # Teachers
  resources :teachers

  # Students
  resources :students

  # Users
  resources :users, only: [:edit, :update] do
    resources :albums, except: :index, shallow: true do
      # Photos
      resources :photos, only: [:new, :edit, :destroy, :update]
      put :add_photos, on: :member
    end
  end

  # Classrooms
  resources :classrooms, shallow: true do
    # Students
    resources :students, only: [:new, :create]
  end

  # Collectios
  [:top_selects, :showcase].each do |collection|
    get "users/:user_id/#{collection}", to: "collections##{collection}", as: "#{collection}"
  end
end
