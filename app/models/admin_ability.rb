class AdminAbility
  include CanCan::Ability

  def initialize(user)
    return if !user.admin?

    can :manage, Alblum, :user_id => user.id
    can :manage, Photo do |photo|
      photo.alblum.user_id = user.id
    end
  end
end
