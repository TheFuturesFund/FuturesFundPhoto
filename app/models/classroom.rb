class Classroom < ActiveRecord::Base
  has_many :students, through: :classroom_students
end