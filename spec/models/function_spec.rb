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

  context 'delegating methods to relations functions' do
    before do
      user.assign_role role
    end

    describe '#name' do
      it 'returns the name of the role' do
        expect(user.functions.first.name).to eq(role.name)
      end
    end

    describe '#username' do
      it 'returns the name of the user' do
        expect(user.functions.first.username).to eq(user.username)
      end
    end
  end

  describe '.current' do
    let(:current_functions_count) { 5 }
    let(:not_vacated_functions_count) { 8 }

    let!(:not_vacated_functions)  { create_list :function, 8 }
    let!(:past_functions) do
      create_list :function, not_vacated_functions_count, :in_past
    end
    let!(:current_functions)  do
      create_list :function, current_functions_count, :current_function
    end

    let!(:future_function) { create :function, assumed_at: DateTime.now + 9 }

    it 'returns all function where vacated_at is nil or not reached' do
      expected = current_functions_count + not_vacated_functions_count
      expect(Function.current.count).to eq(expected)
    end

    it 'returns only functions with vacated nil or vacated_at after today' do
      Function.current.each do |function|
        expect(function.vacated_at).to be > Date.today if function.vacated_at
      end
    end

    it 'returns only functions started in the past' do
      Function.current.each do |function|
        expect(function.assumed_at).to be < Date.today + 1
      end
    end
  end
end
