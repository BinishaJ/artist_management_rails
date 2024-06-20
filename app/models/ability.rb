# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can [:login,:register], SessionsController, public: true
    can :count, Music, public: true
    can :count, User, public: true
    can [:count, :all], Artist, public: true

    can :manage, Music if user.role.id == 3
    can :get_music, Artist if user.role.id == 3

    return if user.role.id == 3
    can [:index, :get_music ], Artist if user.role.id == 1
    can :manage, Artist if user.role.id == 2
    can [:import, :export], :csv if user.role.id == 2

    return unless user.role.id == 1
    can :manage, User

    # Define abilities for the user here. For example:
    #
    #   return unless user.present?
    #   can :read, :all
    #   return unless user.admin?
    #   can :manage, :all
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
    #   can :update, Article, published: true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md
  end
end
