class StudentsController < ApplicationController
  before_action :set_classroom, only: [:create, :new]
  before_action :set_student, only: [:show, :edit, :update, :destroy]

  def index
    @students = Student.all
    authorize @students
  end

  def show
    authorize @student
    @albums = @student.albums.ordered_reverse_chronologically_by_created_at
  end

  def new
    @user = User.new
    @student = Student.new
  end

  def edit
    authorize @student
  end

  def create
    @user = User.new(user_params)
    @student = @classroom.students.new(student_params)
    @user.role = @student
    if @student.valid? && @user.save
      @user.invite!
      redirect_to root_path, notice: "Student was successfully invited."
    else
      render :new
    end
  end

  def update
    authorize @student
    if @student.update(student_params)
      redirect_to @student, notice: 'Student was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @student
    @student.destroy
    redirect_to students_url, notice: 'Student was successfully destroyed.'
  end

  private
    
  def set_student
    @student = Student.find(params[:id])
  end

  def set_classroom
    @classroom = Classroom.find(params[:classroom_id])
  end

  def student_params
    params.require(:student).permit(:first_name, :last_name, :classroom_id)
  end

  def user_params
    temp_password = SecureRandom.urlsafe_base64
    local_params = params.require(:user).permit(:email)
    local_params[:password] = temp_password
    local_params[:password_confirmation] = temp_password
    local_params
  end
end
