class PhotoUrlGenerator
  def initialize(photo, size)
    @photo = photo
    @size = size
  end

  def call
    "#{s3_prefix}/#{photo_filename}#{extension_suffix}"
  end

  private

  def extension_suffix
    if @photo.extension.present? && @photo.processed?
      ".#{@photo.extension}"
    else
      ""
    end
  end

  def photo_filename
    if @photo.processed?
      @size.to_s
    else
      "upload"
    end
  end

  def s3_prefix
    "https://s3.amazonaws.com/#{ENV["S3_BUCKET_NAME"]}/photos/#{@photo.image_id}"
  end
end
