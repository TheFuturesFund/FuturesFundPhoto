class Student < ActiveRecord::Base
  include FullNameable

  has_one :user, as: :role, dependent: :destroy
  has_many :albums, dependent: :destroy
  belongs_to :classroom

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :classroom, presence: true

  def self.ordered_alphabetically_by_last_name
    order(last_name: :asc)
  end
end
