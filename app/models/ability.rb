class Ability
  include CanCan::Ability

  def initialize(user)
    can :access, :rails_admin
    can :dashboard
    user ||= AdminUser.new
    if user.has_role? 'admin'
      can :manage, :all
    elsif user.has_role? 'manager'
      can :manage, [Deal, Merchant, Category, Favorite, Grade, Comment, Discovery, Experience, Credit]
      can :manage, AdminUser, :role=>["manager","staff"]
      can [:read, :update], [User, Picture]
    elsif user.has_role? 'staff'
      can :manage, [Deal, Merchant, Category, Favorite, Grade, Comment, Discovery, Experience, Credit]
      can [:read, :update], [User, Picture]
      can [:read,:update], AdminUser, :id => user.id
    else
      can :read, Deal
    end
  end
end
