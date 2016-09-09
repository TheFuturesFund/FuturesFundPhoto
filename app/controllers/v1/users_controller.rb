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

    def invite
      # TODO
    end

    def create
      @user = User.new(user_params)
      authorize @user

      if @user.save
        render json: @user, status: 201
      else
        render_json_error @user
      end
    end

    def update
      @user = User.find(params[:id])

      @user.assign_attributes(user_params)
      authorize @user

      if @user.save
        render json: @user
      else
        render_json_error @user
      end
    end

    def destroy
      @user = User.find(params[:id])
      authorize @user
      @user.destroy
      render json: "", status: 204
    end

    private

    def user_params
      params.require(:user).permit(
        :email,
        :first_name,
        :last_name,
        :classroom_id,
        :password,
        :password_confirmation,
      )
    end
  end
end
