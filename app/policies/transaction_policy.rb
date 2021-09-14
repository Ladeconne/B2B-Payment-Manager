class TransactionPolicy < ApplicationPolicy
  def new?
    create?
  end

  def create?
    true
  end

  def destroy?
    @record.profile.user == @user
  end
end
