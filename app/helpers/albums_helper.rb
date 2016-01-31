module AlbumsHelper
  def photo_category_button_class(category, button_category)
    if category == button_category
      "btn btn-primary"
    else
      "btn btn-default"
    end
  end

  def photo_modal_id(photo)
    "photoModal#{photo.id}"
  end
end
