class DirectorPolicy < ApplicationPolicy
  def index?
    director?
  end

  def show?
    director? || teacher?
  end

  def create?
    director?
  end

  def update?
    director?
  end

  def destroy?
    director?
  end
end
