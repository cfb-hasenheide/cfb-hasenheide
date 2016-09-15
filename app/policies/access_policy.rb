class AccessPolicy
  include AccessGranted::Policy

  def configure
    role :admin, proc { |user| user.admin? } do
      can :manage, Object
    end

    role :member, proc { |user| user.present? } do
      can :create, Comment
      can [:update, :destroy], Comment do |comment, user|
        comment.user == user
      end

      can :update, Player do |player, user|
        player.member.id == user.member.id
      end

      can :update, Address do |address, user|
        address.member.id == user.member.id
      end

      can :update, Member do |member, user|
        member.id == user.member.id
      end

      can :update, Contact do |contact, user|
        contact.member.id == user.member.id
      end
    end
  end
end
