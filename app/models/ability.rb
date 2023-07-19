# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, [Recipe, Category]

    return unless user.present?

    can :create, Recipe
    can [:update, :destroy], Recipe, user_id: user.id
    can [:edit, :update, :destroy], User, id: user.id
    can :read, :suggestions
    cannot :toggle_favorite, Recipe, user_id: user.id

    return unless user.role == 'admin'

    can :manage, [Recipe, Category, User]
    cannot :read, :suggestions
    cannot :index, User
    
  end
end
