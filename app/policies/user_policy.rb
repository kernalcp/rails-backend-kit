class UserPolicy < ApplicationPolicy
  def index?
    admin?
  end

  def show?
    admin? || record.id == user.id
  end

  def create?
    admin?
  end

  def update?
    admin? || record.id == user.id
  end

  def destroy?
    admin?
  end

  private
  def admin?
    user.role == 'admin'
  end
end