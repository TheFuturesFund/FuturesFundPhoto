class ClassroomsController < ApplicationController
  before_action :set_classroom, only: [:show, :edit, :update, :destroy]

  # GET /classrooms
  # GET /classrooms.json
  def index
    @classrooms = Classroom.ordered_reverse_chronologically_by_created_at
    authorize @classrooms
  end

  # GET /classrooms/1
  # GET /classrooms/1.json
  def show
    authorize @classroom
    @students = @classroom.students.ordered_alphabetically_by_last_name
  end

  # GET /classrooms/new
  def new
    @classroom = Classroom.new
    authorize @classroom
  end

  # GET /classrooms/1/edit
  def edit
    authorize @classroom
  end

  # POST /classrooms
  # POST /classrooms.json
  def create
    @classroom = Classroom.new(classroom_params)
    authorize @classroom

    if @classroom.save
      redirect_to @classroom, notice: 'Classroom was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /classrooms/1
  # PATCH/PUT /classrooms/1.json
  def update
    authorize @classroom
    if @classroom.update(classroom_params)
      redirect_to @classroom, notice: 'Classroom was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /classrooms/1
  # DELETE /classrooms/1.json
  def destroy
    authorize @classroom
    @classroom.destroy
    redirect_to classrooms_url, notice: 'Classroom was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_classroom
      @classroom = Classroom.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def classroom_params
      params.require(:classroom).permit(:name)
    end
end
