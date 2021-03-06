class PhotosController < ApplicationController
  protect_from_forgery :except => [:mark_processed]
  before_action :set_photo, only: [:edit, :update, :destroy]

  # GET /photos/new
  def new
    @album = Album.find(params[:album_id])
    authorize @album.photos.new
  end

  # GET /photos/1/edit
  def edit
    authorize @photo
  end

  # POST /photos
  # POST /photos.json
  def create
    @photo = Photo.new(photo_params)
    authorize @photo

    if @photo.save
      redirect_to @photo, notice: 'Photo was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    authorize @photo
    if @photo.update(photo_params)
      if params[:redirect_url]
        redirect_to params[:redirect_url], notice: 'Photo was successfully updated.'
      else
        redirect_to album_path(@photo.album), notice: 'Photo was successfully updated.'
      end
    else
      render :edit
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    authorize @photo
    @album = @photo.album
    @photo.destroy
    redirect_to @album, notice: 'Photo was successfully destroyed.'
  end

  def mark_processed
    @photo = Photo.find_by(token: params[:token])
    @photo.update(processed: true)
    head :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:name, :image, :category, :album_id, :showcase)
    end
end
