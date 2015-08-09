class Director < ActiveRecord::Base
  has_one :user, as: :role
end
