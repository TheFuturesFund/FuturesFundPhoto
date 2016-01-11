class CreateClassroomStudents < ActiveRecord::Migration
  def change
    create_table :classroom_students do |t|
      t.string :classroom_id
      t.string :student_id

      t.timestamps null: false
    end
  end
end
