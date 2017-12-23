class Ability
  include CanCan::Ability

  def initialize(user)
    def initialize(user)
      user ||= User.new # guest user (not logged in)
      
      if user.superadmin_role?
        can :manage, :all
      end
    end
  end
end
