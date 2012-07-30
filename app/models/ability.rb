class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Alblum
  end
end
