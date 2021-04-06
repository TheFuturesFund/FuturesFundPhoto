class CreatePhotos < ActiveRecord::Migration[4.2]
  def change
    create_table :photos do |t|
      t.string :name
      t.string :image
      t.integer :category, default: 0
      t.integer :album_id

      t.timestamps null: false
    end
  end
end
