class Album < ActiveRecord::Base
  belongs_to :student
  has_many :photos
end
