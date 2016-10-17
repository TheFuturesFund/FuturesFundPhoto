class PhotoSerializer < ActiveModel::Serializer
  attribute :name
  attribute :category
  attribute :image_id
  attribute :showcase

  belongs_to :album
  belongs_to :user do
    object.album.user
  end
end
