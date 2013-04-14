class AdminAbility
  include CanCan::Ability

  def initialize(user)
    return if !user.admin?

    can :manage, Category, :user_id => user.id
    can :manage, Photo do |photo|
      photo.category.user_id = user.id
    end
    can :manage, CarouselPhoto, :user_id => user.id
  end
end
