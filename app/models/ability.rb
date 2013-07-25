class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.is? :admin
      can :manage, :all
    elsif user.is? :member
      can :read, Recipe

      can :manage, Recipe do |recipe|
        recipe.try(:author) == user
      end
    else
      can :read, Recipe
  end
end
