class Album < ActiveRecord::Base
  belongs_to :student
  has_many :photos

  accepts_attachments_for :photos, attachment: :image, append: true
end
