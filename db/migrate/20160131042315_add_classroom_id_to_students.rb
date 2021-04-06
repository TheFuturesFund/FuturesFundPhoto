class AddClassroomIdToStudents < ActiveRecord::Migration[4.2]
  def change
    drop_table :classroom_students
    add_column :students, :classroom_id, :integer
  end
end
