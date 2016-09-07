class StudentPolicy < ApplicationPolicy
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
    director? || teacher? || (user.present? && user == record)
  end

  def destroy?
    director? || teacher?
  end
end
