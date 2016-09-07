class UserPolicy < ApplicationPolicy
  delegate :index?, :show?, :create?, :update?, :destroy?, to: :delegate_policy

  private

  def delegate_policy
    @delegate_class ||= "#{record.role.classify}Policy".constantize
    @delegate_policy ||= @delegate_class.new(user, record)
  end
end
