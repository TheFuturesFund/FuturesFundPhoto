class Director < ActiveRecord::Base
  include FullNameable

  validates :first_name, presence: true
  validates :last_name, presence: true

  has_one :user, as: :role, dependent: :destroy
end
