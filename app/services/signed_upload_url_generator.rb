class SignedUploadUrlGenerator
  def initialize(count)
    @count = count
  end

  def call
    (0...@count).map { generate_url }
  end

  private

  def generate_url
    uid = SecureRandom.uuid
    {
      uuid: uid,
      url: url_presigner.presigned_url(
        :put_object,
        bucket: ENV["S3_BUCKET_NAME"],
        key: "photos/#{uid}/upload",
        content_type: "binary/octet-stream",
        acl: "public-read",
      )
    }
  end

  def url_presigner
    @url_presigner ||= Aws::S3::Presigner.new(client: s3_client)
  end

  def s3_client
    Aws::S3::Client.new(
      access_key_id: ENV["S3_ACCESS_KEY_ID"],
      secret_access_key: ENV["S3_SECRET_ACCESS_KEY"],
      region: ENV["S3_BUCKET_REGION"],
    )
  end
end
