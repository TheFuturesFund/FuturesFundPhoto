class ClassroomPolicy < ApplicationPolicy
  def index?
    director? || teacher?
  end

  def show?
    if director? || teacher?
      true
    elsif student?
      user.role.classrooms.include?(record)
    else
      false
    end
  end

  def create?
    director? || teacher?
  end

  def update?
    director? || teacher?
  end

  def destroy?
    director? || teacher?
  end
end
