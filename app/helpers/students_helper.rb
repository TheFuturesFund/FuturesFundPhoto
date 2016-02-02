module StudentsHelper
  def classroom_select_options
    Classroom.all.map do |classroom|
      [classroom.name, classroom.id]
    end
  end
end
