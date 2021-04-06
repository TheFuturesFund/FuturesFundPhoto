class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :recoverable, :trackable, :validatable

  belongs_to :role, polymorphic: true

  validates_associated :role
  validates :role, presence: true

  # director?, teacher?, student? methods
  [Director, Teacher, Student].each do |role_class|
    define_method("#{role_class.name.underscore}?") do
      role_type == role_class.name
    end
  end
end
