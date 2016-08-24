require 'rails_helper'

RSpec.describe AccessPolicy do
  let(:admin) { double(:user, admin?: true) }
  let(:member) { double(:user, admin?: false) }

  context 'admin' do
    subject { described_class.new(admin) }

    it 'can :create Objects' do
      expect(subject.can?(:create, Object)).to be true
    end

    it 'can :read Objects' do
      expect(subject.can?(:read, Object)).to be true
    end

    it 'can :update Objects' do
      expect(subject.can?(:update, Object)).to be true
    end

    it 'can :destroy Objects' do
      expect(subject.can?(:destroy, Object)).to be true
    end
  end

  context 'member' do
    subject { described_class.new(member) }

    let(:own_comment) { double(:comment, class: Comment, user: member) }
    let(:other_comment) { double(:comment, class: Comment, user: nil) }

    it 'can :create Comments' do
      expect(subject.can?(:create, Comment)).to be true
    end

    it 'can :update own comment' do
      expect(subject.can?(:update, own_comment)).to be true
    end

    it 'cannot :update other comments' do
      expect(subject.can?(:update, other_comment)).to be false
    end

    it 'can :destroy own comment' do
      expect(subject.can?(:destroy, own_comment)).to be true
    end

    it 'cannot :destroy other comments' do
      expect(subject.can?(:destroy, other_comment)).to be false
    end
  end
end
