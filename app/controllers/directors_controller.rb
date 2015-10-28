class DirectorsController < ApplicationController
  before_action :set_director, only: [:show, :edit, :update, :destroy]

  def index
    @directors = Director.all
    authorize @directors
  end

  def show
    authorize @director
  end

  def new
    @director = Director.new
    authorize @director
  end

  def edit
    authorize @director
  end

  def create
    @director = Director.new(director_params)
    authorize @director

    if @director.save
      redirect_to @director, notice: 'Director was successfully created.'
    else
      render :new
    end
  end

  def update
    authorize @director

    if @director.update(director_params)
      redirect_to @director, notice: 'Director was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @director
    @director.destroy
    redirect_to directors_url, notice: 'Director was successfully destroyed.'
  end

  private

  def set_director
    @director = Director.find(params[:id])
  end

  def director_params
    params.require(:director).permit(:first_name, :last_name)
  end
end
