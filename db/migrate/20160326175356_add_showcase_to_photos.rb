class AddShowcaseToPhotos < ActiveRecord::Migration[4.2]
  def change
    add_column :photos, :showcase, :boolean, default: false
  end
end
