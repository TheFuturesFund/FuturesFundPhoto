class ClassroomPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.present?
        scope.all
      else
        scope.none
      end
    end
  end

  def index?
    user.present?
  end

  def show?
    user.present?
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
