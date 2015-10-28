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
    @teacher = Teacher.new
    authorize @teacher
  end

  def edit
  end

  def create
    @teacher = Teacher.new(teacher_params)
    authorize @teacher

    respond_to do |format|
      if @teacher.save
        redirect_to @teacher, notice: 'Teacher was successfully created.'
      else
        render :new
      end
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
end
