class CreateClassrooms < ActiveRecord::Migration[4.2]
  def change
    create_table :classrooms do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
