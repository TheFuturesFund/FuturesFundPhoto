module V1
  class PhotosController < ApiController
    def index
      @photos = policy_scope(Photo)
        .ordered_reverse_chronologically_by_created_at
        .page(pagination_params[:number])
        .per(pagination_params[:size])
      render_json_index @photos
    end

    def show
      @photo = Photo.find(params[:id])
      authorize @photo
      render json: @photo
    end

    def create
      @photo = Photo.new(photo_params)
      authorize @photo

      if @photo.save
        render json: @photo, status: 201
      else
        render_json_error @photo
      end
    end

    def update
      @photo = Photo.find(params[:id])

      @photo.assign_attributes(photo_params)
      authorize @photo

      if @photo.save
        render json: @photo
      else
        render_json_error @photo
      end
    end

    def destroy
      @photo = Photo.find(params[:id])
      authorize @photo
      @photo.destroy
      render json: "", status: 204
    end

    private

    def photo_params
      params.require(:photo).permit(
        :name,
        :category,
        :album_id,
        :image_id,
        :showcase,
      )
    end
  end
end
