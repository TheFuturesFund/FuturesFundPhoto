class FixForeignKeyOnClassroomStudents < ActiveRecord::Migration[4.2]
  def change
    remove_column :classroom_students, :student_id
    remove_column :classroom_students, :classroom_id

    add_column :classroom_students, :student_id, :integer
    add_column :classroom_students, :classroom_id, :integer
  end
end
