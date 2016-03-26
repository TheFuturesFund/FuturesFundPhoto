class CollectionsController < ApplicationController
  before_action :set_student

  def top_selects
    @photos = @student.photos.top_select_category
  end

  def showcase
    # TODO
  end

  private

  def set_student
    @student = Student.find(params[:student_id])
  end
end
