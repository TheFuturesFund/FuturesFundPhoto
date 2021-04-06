class Photo < ApplicationRecord
  enum category: [
    :outtake_category,
    :select_category,
    :top_select_category
  ]

  before_validation :set_token
  before_save :set_initial_name

  validates :category, presence: true
  validates :image_id, presence: true, uniqueness: true
  validates :token, presence: true
  validates :album, presence: true

  belongs_to :album
  has_one :student, through: :album

  def image_url(size = :original)
    PhotoUrlGenerator.new(self, size).call()
  end

  def process_image
    ProcessImageMessageSender.new(self).call()
  end

  def set_initial_name
    self.name ||= SecureRandom.uuid
  end

  def set_token
    self.token ||= SecureRandom.urlsafe_base64
  end

  def self.showcase
    where(showcase: true)
  end

  def self.ordered_by_category
    order(category: :desc)
  end

  def self.ordered_reverse_chronologically_by_created_at
    order(created_at: :desc)
  end
end
