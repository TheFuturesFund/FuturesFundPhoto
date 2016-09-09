Doorkeeper.configure do
  orm :active_record

  grant_flows %w(password)

  use_refresh_token

  resource_owner_authenticator do
    current_user
  end

  resource_owner_from_credentials do
    user = User.find_for_database_authentication(email: params[:username])
    if user.present? && user.valid_password?(params[:password])
      user
    end
  end
end
