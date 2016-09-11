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
      can [:update, :destroy], ForumThread do |forum_thread, user|
        forum_thread.user == user
      end
    end
  end
end
