class UserPolicy < ApplicationPolicy
  def edit?
    update?
  end

  def update?
    director? || teacher? || (user.present? && user == record)
  end
end
