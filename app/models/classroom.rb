class Classroom < ApplicationRecord
  has_many :students, dependent: :destroy

  validates :name, presence: true

  def self.ordered_reverse_chronologically_by_created_at
    order(created_at: :desc)
  end
end
