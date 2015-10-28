class UsersController < ApplicationController
  def dashboard
    if user_signed_in? 
      redirect_to current_user.role
    else
      redirect_to new_user_session_url
    end
  end
end
