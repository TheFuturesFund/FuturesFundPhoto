class UsersController < ApplicationController
  def index
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def dashboard
    if user_signed_in? 
      redirect_to current_user.role
    else
      redirect_to new_user_session_url
    end
  end
end
