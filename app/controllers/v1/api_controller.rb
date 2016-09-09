module V1
  class ApiController < ActionController::Base
    include Pundit

    before_action :doorkeeper_authorize!
    after_action :verify_authorized, except: :index
    after_action :verify_policy_scoped, only: :index

    protected

    def current_user
      @current_user ||= User.find(doorkeeper_token[:resource_owner_id])
    end

    def render_json_index(collection)
      render(
        json: collection,
        include: params[:include],
        meta: pagination_meta(collection),
      )
    end

    def render_json_error(resource)
      render(
        json: resource,
        status: 422,
        serializer: ActiveModel::Serializer::ErrorSerializer,
      )
    end

    def pagination_params
      params[:page].try(
        :permit,
        :size,
        :number,
      ) || {}
    end

    private

    def pagination_meta(collection)
      {
        pagination: {
          current_page: collection.current_page,
          total_pages:  collection.total_pages,
          per_page:     collection.limit_value,
        },
      }
    end
  end
end
