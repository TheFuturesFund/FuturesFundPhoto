class AlbumsController < ApplicationController
  before_action :set_student, only: [:new, :create]
  before_action :set_album, only: [:show, :edit, :update, :destroy, :add_photos]

  # GET /albums
  # GET /albums.json
  def index
    @albums = Album.all
  end

  # GET /albums/1
  # GET /albums/1.json
  def show
    @category = params[:category] || "all"
    if @category == "all"
      @photos = @album.photos.ordered_by_category
                             .ordered_reverse_chronologically_by_created_at
    elsif Photo.categories.keys.include? @category
      @photos = @album.photos.where(category: Photo.categories[@category])
                             .ordered_by_category
                             .ordered_reverse_chronologically_by_created_at
    else
      @photos = []
    end
  end

  # GET /albums/new
  def new
    @album = Album.new
  end

  # GET /albums/1/edit
  def edit
  end

  # POST /albums
  # POST /albums.json
  def create
    @album = @student.albums.new(album_params)
      if @album.save
        redirect_to new_album_photo_path(@album), notice: 'Album was successfully created.'
      else
        render :new
      end
  end

  # PATCH/PUT /albums/1
  # PATCH/PUT /albums/1.json
  def update
    respond_to do |format|
      if @album.update(album_params)
        format.html { redirect_to @album, notice: 'Album was successfully updated.' }
        format.json { render :show, status: :ok, location: @album }
      else
        format.html { render :edit }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  def add_photos
    if @album.update(add_photos_params)
      redirect_to @album, notice: "Photos were successfully added"
    else
      render "photos/new"
    end
  end

  # DELETE /albums/1
  # DELETE /albums/1.json
  def destroy
    @album.destroy
    respond_to do |format|
      format.html { redirect_to albums_url, notice: 'Album was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_student
      @student = Student.find(params[:student_id])
    end

    def set_album
      @album = Album.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def album_params
      params.require(:album).permit(:name, :student_id, photos_images: [])
    end

    def add_photos_params
      params.require(:album).permit(photos_images: [])
    end
end
