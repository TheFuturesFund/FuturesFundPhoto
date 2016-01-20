class ChangeImageToImageIdOnPhoto < ActiveRecord::Migration
  def change
    remove_column :photos, :image
    add_column :photos, :image_id, :string
  end
end
