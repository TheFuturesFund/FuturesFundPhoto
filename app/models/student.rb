class Student < ActiveRecord::Base
  include FullNameable

  has_one :user, as: :role
  has_many :classroom_students
  has_many :classrooms, through: :classroom_students
  has_many :albums, dependent: :destroy

  def self.ordered_alphabetically_by_last_name
    order(last_name: :asc)
  end
end
