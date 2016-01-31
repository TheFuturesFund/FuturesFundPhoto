class Album < ActiveRecord::Base
  belongs_to :student
  has_many :photos, dependent: :destroy

  accepts_attachments_for :photos, attachment: :image, append: true

  def self.ordered_reverse_chronologically_by_created_at
    order(created_at: :desc)
  end
end
