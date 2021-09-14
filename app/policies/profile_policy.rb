class ProfilePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: @user)
    end
  end

  def new?
    create?
  end

  def create?
    true
  end

  def dashboard?
    @record.user == @user
  end

  def destroy?
    @record.user == @user
  end

  def invoices?
    @record.user == @user
  end

  def payments?
    @record.user == @user
  end
end
