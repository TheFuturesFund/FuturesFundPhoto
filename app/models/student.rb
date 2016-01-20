class Student < ActiveRecord::Base
  include FullNameable

  has_one :user, as: :role
  has_many :classroom_students
  has_many :classrooms, through: :classroom_students
  has_many :albums
end
