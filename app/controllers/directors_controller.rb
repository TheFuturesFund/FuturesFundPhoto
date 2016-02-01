class DirectorsController < ApplicationController
  before_action :set_director, only: [:show, :edit, :update, :destroy]

  def index
    @directors = Director.all
    authorize @directors
  end

  def show
    authorize @director
  end

  def new
    @user = User.new
    @director = Director.new
  end

  def edit
    authorize @director
  end

  def create
    @user = User.new(user_params)
    @director = Director.new(director_params)
    @user.role = @director
    if @director.valid? && @user.save
      @user.invite!
      redirect_to root_path, notice: "Director was successfully invited."
    else
      render :new
    end
  end

  def update
    authorize @director

    if @director.update(director_params)
      redirect_to @director, notice: 'Director was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @director
    @director.destroy
    redirect_to directors_url, notice: 'Director was successfully destroyed.'
  end

  private

  def set_director
    @director = Director.find(params[:id])
  end

  def director_params
    params.require(:director).permit(:first_name, :last_name)
  end

  def user_params
    temp_password = SecureRandom.urlsafe_base64
    local_params = params.require(:user).permit(:email)
    local_params[:password] = temp_password
    local_params[:password_confirmation] = temp_password
    local_params
  end
end
