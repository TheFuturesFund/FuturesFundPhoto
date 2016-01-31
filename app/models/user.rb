class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :trackable, :validatable

  belongs_to :role, polymorphic: true

  validates :role, presence: true
  
  # director?, teacher?, student? methods
  [Director, Teacher, Student].each do |role_class|
    define_method("#{role_class.name.underscore}?") do
      role_type == role_class.name
    end
  end
end
