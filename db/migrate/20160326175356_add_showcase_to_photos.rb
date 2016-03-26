class AddShowcaseToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :showcase, :boolean, default: false
  end
end
