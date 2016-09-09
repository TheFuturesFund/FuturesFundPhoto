module V1
  class ClassroomsController < ApiController
    def index
      @classrooms = policy_scope(Classroom)
        .ordered_reverse_chronologically_by_created_at
        .page(pagination_params[:number])
        .per(pagination_params[:size])
      render_json_index @classrooms
    end

    def show
      @classroom = Classroom.find(params[:id])
      authorize @classroom
      render json: @classroom
    end

    def create
      @classroom = Classroom.new(classroom_params)
      authorize @classroom

      if @classroom.save
        render json: @classroom, status: 201
      else
        render_json_error @classroom
      end
    end

    def update
      @classroom = Classroom.find(params[:id])

      @classroom.assign_attributes(classroom_params)
      authorize @classroom

      if @classroom.save
        render json: @classroom
      else
        render_json_error @classroom
      end
    end

    def destroy
      @classroom = Classroom.find(params[:id])
      authorize @classroom
      @classroom.destroy
      render json: "", status: 204
    end

    private

    def classroom_params
      params.require(:classroom).permit(
        :name,
      )
    end
  end
end
