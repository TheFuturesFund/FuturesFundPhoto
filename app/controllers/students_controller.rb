class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]

  def index
    @students = Student.all
    authorize @students
  end

  def show
    authorize @student
  end

  def new
    @student = Student.new
    authorize @student
  end

  def edit
    authorize @student
  end

  def create
    @student = Student.new(student_params)
    authorize @student

    if @student.save
      redirect_to @student, notice: 'Student was successfully created.'
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

  def student_params
    params.require(:student).permit(:first_name, :last_name)
  end
end
