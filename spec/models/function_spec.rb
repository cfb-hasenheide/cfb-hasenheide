require 'rails_helper'

RSpec.describe Function, type: :model do
  let(:role) { create :role }
  let(:user) { create :user }
  let(:function) do
    create :function, :current, role: role, user: user
  end

  describe '.current' do
    subject { Function.current }

    context 'no function exist' do
      let!(:functions) { create :function, :past }

      it 'returns an empty array' do
        expect(subject).to eq([])
      end
    end

    context 'only current functions are existing' do
      let!(:functions) do
        create_list :function, 2, :current
        create :function, :past, vacated_at: nil
      end

      it 'returns all functions' do
        expect(subject.count).to eq(Function.count)
      end
    end

    context 'only past and future functions exist' do
      let!(:functions) do
        create :function, :past
        create :function, :future
      end

      it 'returns an empty array' do
        expect(subject).to eq([])
      end
    end

    context 'existing of current, past and future functions' do
      let!(:current_functions) { create_list :function, 2, :current }
      let!(:past_functionss) { create_list :function, 1, :past }
      let!(:future_functions) { create_list :function, 2, :future }

      it 'only returns the current functions' do
        expect(subject.count).to eq(current_functions.count)
      end
    end
  end

  describe '#name' do
    it 'returns the name of the role' do
      expect(function.name).to eq(role.name)
    end
  end

  describe '#username' do
    it 'returns the name of the user' do
      expect(function.username).to eq(user.username)
    end
  end

  describe '#update' do
    let(:new_function) do
      create :function, role: role, user: user,
        assumed_at: function.vacated_at + 10,
        vacated_at: function.vacated_at + 20
    end

    it 'updates the function' do
      expect(function.update(vacated_at: nil)).to be_truthy
    end

    context 'vacated_at < assumed_at' do
      it 'cannot be updated' do
        updated = function.update(assumed_at: function.vacated_at,
                                  vacated_at: function.assumed_at)
        expect(updated).to be_falsy
      end
    end

    context 'same role and user' do
      context 'into already existing time of other function' do
        it 'cannot be updated' do
          updated = new_function.update(vacated_at: function.vacated_at)
          expect(updated).to be_falsy
        end
      end
    end
  end

  describe '#create' do
    let(:existing_function) { create :function, :current }
    let(:user) { existing_function.user }
    let(:role) { existing_function.role }
    let(:assumed_at) { existing_function.assumed_at }
    let(:vacated_at) { existing_function.vacated_at }

    subject do
      function = Function.new(user: user, role: role,
                              vacated_at: vacated_at, assumed_at: assumed_at)
      function.save
    end

    context 'same user and role' do
      it 'cannot create same function in same time' do
        expect(subject).to be_falsy
      end
    end

    context 'same role and user during existing function' do
      let(:assumed_at) { existing_function.assumed_at + 1 }
      let(:vacated_at) { existing_function.vacated_at - 1 }

      it 'cannot create during existing' do
        expect(subject).to be_falsy
      end
    end

    context 'same time and user, but different role' do
      let(:role) { create :role }

      it 'creates new function for same user in differ role' do
        expect(subject).to be_truthy
      end
    end
  end
end
