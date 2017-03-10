class UploadUrlsController < ApplicationController
  def index
    authorize Photo.new, :new?
    count = params[:count].to_i || 1
    render json: SignedUploadUrlGenerator.new(count).call
  end
end
