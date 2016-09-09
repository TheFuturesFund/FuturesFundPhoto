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
  end
end
