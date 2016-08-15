require 'rails_helper'

RSpec.describe Function, type: :model do
  let(:role) { create :role }
  let(:user) { create :user }

  context 'roles assignable to users' do
    it 'assigns the role to the user' do
      expect do
        user.roles << role
        user.save
      end.to change { user.functions.count }.from(0).to(1)
    end
  end

  describe '.create' do
    it 'assigns roles to user' do
      expect do
        Function.create(user_id: user.id, role_id: role.id)
      end.to change { user.functions.count }.from(0).to(1)
    end
  end

  describe '.for' do
    it 'assigns roles to user' do
      expect do
        Function.for(user, role)
      end.to change { user.functions.count }.from(0).to(1)
    end
  end
end
