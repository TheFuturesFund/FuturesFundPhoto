class AlbumPolicy < ApplicationPolicy
  def index?
    if director? || teacher?
      true
    elsif student?
      user.role.albums.exists? record
    else
      false
    end
  end

  def show?
    if director? || teacher?
      true
    elsif student?
      user.role.albums.include?(record)
    else
      false
    end
  end

  def create?
    user.present?
  end

  def update?
    if director? || teacher?
      true
    elsif student?
      user.role.albums.include?(record)
    else
      false
    end
  end

  def destroy?
    if director? || teacher?
      true
    elsif student?
      user.role.albums.include?(record)
    else
      false
    end
  end
end
