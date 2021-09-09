class ProfilePolicy < ApplicationPolicy
  def new?
    create?
  end

  def create?
    true
  end

  def dashboard?
    @record.user == @user
  end

  def invoices?
    @record.user == @user
  end

  def payments?
    @record.user == @user
  end
end
