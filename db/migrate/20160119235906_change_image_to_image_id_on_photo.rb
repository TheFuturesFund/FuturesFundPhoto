class ChangeImageToImageIdOnPhoto < ActiveRecord::Migration[4.2]
  def change
    remove_column :photos, :image
    add_column :photos, :image_id, :string
  end
end
