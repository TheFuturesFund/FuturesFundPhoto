class Photo < ActiveRecord::Base
  enum category: [
    :outtake_category,
    :select_category,
    :top_select_category
  ]

  before_save :set_initial_name

  validates :name, presence: true, on: :update
  validates :category, presence: true
  validates :album, presence: true

  attachment :image

  belongs_to :album

  def set_initial_name
    name ||= SecureRandom.uuid
  end

  def self.ordered_by_category
    order(category: :desc)
  end

  def self.ordered_reverse_chronologically_by_created_at
    order(created_at: :desc)
  end 
end
