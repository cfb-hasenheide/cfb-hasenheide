class AccessPolicy
  include AccessGranted::Policy

  def configure
    role :admin, proc { |user| user&.admin? } do
      can :manage, Object
    end

    role :member, proc { |user| user.present? } do
      can :update, Address do |address, user|
        address.addressable_type == 'Member' &&
          address.addressable.user == user
      end

      can :create, Comment

      can :update, Contact do |contact, user|
        contact.member.user == user
      end

      can [:update, :destroy], Comment do |comment, user|
        comment.user == user
      end

      can :update, Member do |member, user|
        member.user == user
      end

      can :update, Player do |player, user|
        player.member.user == user
      end
    end
  end
end
