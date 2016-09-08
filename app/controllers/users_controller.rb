class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]

  def dashboard
    if user_signed_in?
      redirect_to current_user.role
    else
      redirect_to new_user_session_url
    end
  end

  def edit
    authorize @user
  end

  def update
    authorize @user
    if @user.update_with_password(user_params)
      sign_in @user, bypass: true
      redirect_to @user.role, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :email,
      :password,
      :password_confirmation,
      :current_password,
    )
  end

  def set_user
    @user = User.find(params[:id])
  end
end
