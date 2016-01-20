class Teacher < ActiveRecord::Base
  include FullNameable
  
  has_one :user, as: :role
end
