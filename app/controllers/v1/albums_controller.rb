module V1
  class AlbumsController < ApiController
    def index
      @albums = policy_scope(Album)
        .ordered_reverse_chronologically_by_created_at
        .page(pagination_params[:number])
        .per(pagination_params[:size])
      render_json_index @albums
    end

    def show
      @album = Album.find(params[:id])
      authorize @album
      render json: @album
    end

    def create
      @album = Album.new(album_params)
      authorize @album

      if @album.save
        render json: @album, status: 201
      else
        render_json_error @album
      end
    end

    def update
      @album = Album.find(params[:id])

      @album.assign_attributes(album_params)
      authorize @album

      if @album.save
        render json: @album
      else
        render_json_error @album
      end
    end

    def destroy
      @album = Album.find(params[:id])
      authorize @album
      @album.destroy
      render json: "", status: 204
    end

    private

    def album_params
      params.require(:album).permit(
        :name,
        :user_id,
      )
    end
  end
end
