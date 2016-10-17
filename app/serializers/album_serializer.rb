class AlbumSerializer < ActiveModel::Serializer
  attribute :name
  belongs_to :user
end
