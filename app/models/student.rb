class Student < ActiveRecord::Base
  include FullNameable

  has_one :user, as: :role
  belongs_to :classroom
  has_many :albums, dependent: :destroy

  def self.ordered_alphabetically_by_last_name
    order(last_name: :asc)
  end
end
