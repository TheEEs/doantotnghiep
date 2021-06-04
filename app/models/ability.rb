# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :access, :rails_admin   # grant access to rails_admin
    can :read, :dashboard       # grant access to the dashboard
    if user.root?
      can :manage, :all 
    elsif user.admin? 
      can :read, :statistic
      can :read, User, {role: 2}
      can :read, User, {id: user.id}
      can :update, User do |u| 
        (u.id == user.id || u.role == "user")
      end
      can [:create, :destroy], User do |u| 
        u.role == "user"
      end
      can :manage, [History, Product, HistoryItem]
      cannot :show, HistoryItem
    elsif user.user?
      can :read, :statistic
      can :manage, [History, Product, HistoryItem]
      cannot :show, HistoryItem
    end
  end
end
