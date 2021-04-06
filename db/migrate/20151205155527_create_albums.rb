class CreateAlbums < ActiveRecord::Migration[4.2]
  def change
    create_table :albums do |t|
      t.string :name
      t.integer :student_id

      t.timestamps null: false
    end
  end
end
