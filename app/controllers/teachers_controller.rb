class TeachersController < ApplicationController
  before_action :set_teacher, only: [:show, :edit, :update, :destroy]

  def index
    @teachers = Teacher.all
    authorize @teachers
  end

  def show
    authorize @teacher
  end

  def new
    @user = User.new
    @teacher = Teacher.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    @teacher = Teacher.new(teacher_params)
    @user.role = @teacher
    if @teacher.valid? && @user.save
      @user.invite!
      redirect_to root_path, notice: "Teacher was successfully invited."
    else
      render :new
    end
  end

  def update
    authorize @teacher
    if @teacher.update(teacher_params)
      redirect_to @teacher, notice: 'Teacher was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @teacher
    @teacher.destroy
    redirect_to teachers_url, notice: 'Teacher was successfully destroyed.'
  end

  private

  def set_teacher
    @teacher = Teacher.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def teacher_params
    params.require(:teacher).permit(:first_name, :last_name)
  end

  def user_params
    temp_password = SecureRandom.urlsafe_base64
    local_params = params.require(:user).permit(:email)
    local_params[:password] = temp_password
    local_params[:password_confirmation] = temp_password
    local_params
  end
end
