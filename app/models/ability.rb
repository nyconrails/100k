class Ability
  include CanCan::Ability

  def initialize(user)

    return unless user

    if(user.is_a?(AdminUser))
      #Basic Admin Abilities
      can :read, Application
      can :create, Vetting
      can :update, Vetting

      #Add Content permissions if user is editor
      can :manage, Content if user.editor?
      can :manage, Upload if user.editor?
      can :manage, Opportunity if user.editor?
      can :manage, Organization if user.editor?
      can :manage, User if user.editor?

      #Add Super User privileges
      can :manage, :all if user.super_user?
    else
      cannot :manage, :all
      can :read, :all

      can [:custom_organization_update], Organization # Modified on 10-Mar-2012 to provide Editable Screen to Regular Users
      can [:custom_user_update], Organization # Modified on 12-Mar-2012 to provide Editable Screen to Regular Users

      can [:edit, :update], Organization do |org|
        (user.organization == org) && user.organization_admin?  # Modified to allow Admin link available only for Organization_admin users (i.e. Primary contact).
      end
      can [:post], Organization do |org|
        user.organization == org
      end

      can [:edit], Post do |post|
        post.user == user || user.organization_admin? #Modified on 9-Mar-2012 to allow Admin to EDIT posts
      end
      can [:destroy], Post do |post|
        post.user == user || user.organization_admin?
      end

      can [:my_account, :update_account], User
      can [:index, :new], User if user.organization_admin?
      can [:show, :edit, :update, :create, :destroy], User do |usr|         # Modified on 14-Mar-2012 to allow admin to Delete Org-user by adding destroy call to abilities.
        (usr.organization==user.organization && user.organization_admin?) || usr.new_record?
      end
      can [:reset_password, :welcome], User do |usr|
        user.organization_admin? && usr.organization==user.organization
      end

      can :manage, :all if user.super_admin?

    end

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
