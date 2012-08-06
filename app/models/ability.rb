class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Album

    if user
      can :read, Order, :user_id => user.id
      can :download, Order, :user_id => user.id
    end
  end
end
