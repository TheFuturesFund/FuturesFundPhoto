class ProcessImageMessageSender
  def initialize(image)
    @image = image
  end

  def call
    send_sqs_message
  end

  private

  def formatted_message
    {
      extension: @image.extension,
      image_id: @image.image_id,
      token: @image.token,
    }.to_json
  end

  def send_sqs_message
    sqs_client.send_message(
      queue_url: ENV["SQS_QUEUE_URL=https"],
      message_body: formatted_message,
      message_group_id: "futuresfundphoto",
      message_deduplication_id: @image.image_id,
    )
  end

  def sqs_client
    @sqs_client = Aws::SQS::Client.new(
      access_key_id: ENV["S3_ACCESS_KEY_ID"],
      secret_access_key: ENV["S3_SECRET_ACCESS_KEY"],
      region: ENV["S3_BUCKET_REGION"],
    )
  end
end
