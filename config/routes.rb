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

  # Users
  resources :users, only: [:edit, :update]

  # Process Photos
  put "photos/process", to: "photos#mark_processed"

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

  # Upload URLs
  get 'upload_urls/', to: "upload_urls#index"

  # Collectios
  [:top_selects, :showcase].each do |collection|
    get "students/:student_id/#{collection}", to: "collections##{collection}", as: "#{collection}"
  end
end
