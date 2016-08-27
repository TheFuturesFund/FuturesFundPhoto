class User < ActiveRecord::Base
  devise :invitable, :database_authenticatable, :recoverable, :trackable, :validatable

  enum role: [:student, :teacher, :director]

  has_many :albums, dependent: :destroy
  has_many :photos, through: :albums
  belongs_to :classroom

  validates :classroom, presence: true, if: :student?
  validates :classroom, absence: true, if: :teacher?
  validates :classroom, absence: true, if: :director?
  validates :first_name, presence: true, length: { minimum: 3 }
  validates :last_name, presence: true, length: { minimum: 3 }
  validates :role, presence: true

  def full_name
    [first_name, last_name].compact.join(' ')
  end

  def self.ordered_alphabetically_by_last_name
    order(last_name: :asc)
  end
end
