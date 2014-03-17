class Ability
  include CanCan::Ability

  def initialize(user)
    can :access, :rails_admin   # grant access to rails_admin
    can :dashboard
    user ||= AdminUser.new # guest user (not logged in)
    if user.has_role? 'admin'
      can :manage, :all
    elsif user.has_role? 'manager'
      can :manage, [Deal, Merchant, Category, Favorite, Grade, Comment, Article, Experience, Credit]
      can [:read], [ArticleType]
      can :manage, AdminUser, :role=>["manager","staff"]
      can [:read, :update], [User, Picture]
    elsif user.has_role? 'staff'
      can :manage, [Deal, Merchant, Category, Favorite, Grade, Comment, Article, Experience, Credit]
      can [:read], [ArticleType]
      can [:read, :update], [User, Picture]
      can [:read,:update], AdminUser, :id => user.id
    else
      can :read, Deal
    end
  end
end
