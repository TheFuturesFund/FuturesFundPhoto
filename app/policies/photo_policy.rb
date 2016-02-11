class PhotoPolicy < ApplicationPolicy
  def index?
    user
  end

  def show?
    user
  end

  def new?
    user.present?
  end

  def create?
    mutate?
  end

  def update?
    mutate?
  end

  def destroy?
    mutate?
  end

  private def mutate?
    if director? || teacher?
      true
    elsif student?
      user.role.albums.include?(record.album)
    else
      false
    end
  end
end
