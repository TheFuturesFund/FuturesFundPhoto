module V1
  class UsersController < ApiController
    def index
      @users = User.all
      render json: @users, include: include_params
    end

    def show
      @user = User.find(params[:id])
      render json: @user, include: include_params
    end

    private

    def include_params
      params.permit(:include)[:include]
    end
  end
end
