class CreateClassroomStudents < ActiveRecord::Migration[4.2]
  def change
    create_table :classroom_students do |t|
      t.string :classroom_id
      t.string :student_id

      t.timestamps null: false
    end
  end
end
