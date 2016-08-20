require 'rails_helper'

RSpec.describe Function, type: :model do
  let(:role) { create :role }
  let(:user) { create :user }
  let(:function) do
    create :function, :current_function, role: role, user: user
  end


  describe '.for' do
    it 'assigns roles to user' do
      expect do
        Function.for(user, role)
      end.to change { user.functions.count }.from(0).to(1)
    end
  end


  context 'delegating methods to relations functions' do
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

  context 'validate assumed_at and vacated_at' do
    let(:assumed_at) { DateTime.now }
    let(:new_function) do
      build :function, assumed_at: assumed_at, vacated_at: vacated_at
    end

    context 'assumed_at > vacated_at' do
      let(:vacated_at) { assumed_at - 10 }

      it 'cannot persist the function' do
        expect(new_function.save).to be_falsy
      end
    end

    context 'assumed_at < vacated_at' do
      let(:vacated_at) { assumed_at + 10 }

      it 'persists the function' do
        expect(new_function.save).to be_truthy
      end
    end
  end

  describe '#update' do
    let(:updating_function) do
      create :function, role: function.role, user: function.user,
        assumed_at: function.vacated_at + 10,
        vacated_at: function.vacated_at + 20
    end


    context 'no times overlapping with existing function' do
      let(:time_for_update) { updating_function.vacated_at + 2 }

      subject { updating_function.update(vacated_at: time_for_update) }

      it 'updates the function' do
        expect(subject).to be_truthy
      end
    end

    context 'times will be overlapping with existing existing function' do
      let(:time_for_update) { function.vacated_at - 2 }

      subject { updating_function.update(assumed_at: time_for_update) }

      it 'cannot update the function' do
        expect(subject).to be_falsy
      end
    end
  end

  context 'same user and role' do
    let(:new_function) do
      build :function,
        user: user,
        role: role,
        assumed_at: assumed_at,
        vacated_at: vacated_at
    end

    context 'during the existing time of other function' do
      let(:assumed_at) { function.assumed_at }
      let(:vacated_at) { function.vacated_at + 1 }

      it 'cannot be created' do
        expect(new_function.save).to be_falsy
      end

    end

    context 'different time line' do
      let(:assumed_at) { function.vacated_at }
      let(:vacated_at) { function.vacated_at + 100 }

      it 'can be created' do
        expect(new_function.save).to be_truthy
      end
    end
  end
end
