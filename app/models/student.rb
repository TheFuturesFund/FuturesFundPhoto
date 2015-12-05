class Student < ActiveRecord::Base
  has_one :user, as: :role
  has_many :albums
end
