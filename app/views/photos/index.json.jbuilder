json.array!(@photos) do |photo|
  json.extract! photo, :id, :name, :image, :category, :album_id
  json.url photo_url(photo, format: :json)
end
