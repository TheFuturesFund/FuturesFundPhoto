class DirectorPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def show?
    user.present?
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
