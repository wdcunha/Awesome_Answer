# To create this file, run the command after installing `cancancan`:
# rails g cancan:ability

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
      user ||= User.new # guest user (not logged in)
      if user.is_admin?
        can :manage, :all
      else
        can :read, :all
      end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities

    # There a few special names for the first argument such as :manage which
    # groups all :read, :create, :update and :destroy actions. Otherwise, you
    # can define your own names.
    can :manage, Question do |question|
      user == question.user
    end
    # Example usage testing this rule:
    # can?(:manage, @question)
    can :manage, Answer do |answer|
      answer.user == user
    end
  end
end
