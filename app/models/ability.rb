# # frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new 

    user.roles.each do |role|
      role.permissions.each do |permission|
        if permission.subject_class == 'all'
          can permission.action.to_sym, :all
        else
          can permission.action.to_sym, permission.subject_class.constantize
        end
      end
    end
    
     can [:update, :destroy], Recipe, user_id: user.id
  end
end

# class Ability
#   include CanCan::Ability

#   def initialize(user)
#     can :read, [Recipe, Category]

#     return unless user.present?

#     can :create, Recipe
#     can [:update, :destroy], Recipe, user_id: user.id
#     can [:edit, :update, :destroy], User, id: user.id
#     can :read, :suggestions
#     cannot :toggle_favorite, Recipe, user_id: user.id

#     return unless user.role == 'admin'

#     can :manage, [Recipe, Category, User]
#     cannot :read, :suggestions
#     cannot :index, User
    
#   end
# end



