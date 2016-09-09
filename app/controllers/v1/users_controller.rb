module V1
  class UsersController < ApiController
    def index
      @users = policy_scope(User)
        .ordered_alphabetically_by_last_name
        .page(pagination_params[:number])
        .per(pagination_params[:size])
      render_json_index @users
    end

    def show
      @user = User.find(params[:id])
      authorize @user
      render json: @user, include: params[:include]
    end
  end
end
