module V1
  class ClassroomsController < ApiController
    def index
      @classrooms = Classroom.all
      render json: @classrooms
    end

    def show
      @classroom = Classroom.find(params[:id])
      render json: @classroom
    end
  end
end
