class UserSerializer < ActiveModel::Serializer
  attribute :email
  attribute :role
  attribute :first_name
  attribute :last_name

  belongs_to :classroom, if: :student?

  delegate :student?, to: :object
end
