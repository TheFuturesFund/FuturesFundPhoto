class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.present?
        scope.all
      else
        scope.none
      end
    end
  end

  delegate :index?, :show?, :create?, :update?, :destroy?, to: :delegate_policy

  private

  def delegate_policy
    @delegate_class ||= "#{record.role.classify}Policy".constantize
    @delegate_policy ||= @delegate_class.new(user, record)
  end
end
