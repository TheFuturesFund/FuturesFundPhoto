class AlbumPolicy < ApplicationPolicy
  def new?
    user.present?
  end

  def index?
    user.present?
  end

  def show?
    user.present?
  end

  def create?
    user.present?
  end

  def edit?
    update?
  end

  def update?
    if director? || teacher?
      true
    elsif student?
      user.albums.include?(record)
    else
      false
    end
  end

  def destroy?
    if director? || teacher?
      true
    elsif student?
      user.albums.include?(record)
    else
      false
    end
  end
end
