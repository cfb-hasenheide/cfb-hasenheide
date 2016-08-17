require 'rails_helper'

describe User do
  let(:user) { create :user }
  let(:role) { create :role }

  describe '#assign_role' do
    context 'no dates given' do
      it 'assigns the role to the user' do
        expect do
          user.assign_role(role)
        end.to change { user.roles.count }.by(1)
      end
    end

    context 'start and end date given' do
      let(:start_date) { DateTime.new }
      let(:end_date) { DateTime.new + 2.days }

      before do
        user.assign_role(role, start_date, end_date)
      end

      it 'assigns a role to the user' do
        expect(user.functions.count).to eq(1)
      end

      it 'assigned role has with given start date' do
        expect(user.functions.first.assumed_at).to eq(start_date)
      end

      it 'assigned role has with given end date' do
        expect(user.functions.first.vacated_at).to eq(end_date)
      end
    end
  end

  describe '#current_function' do
    before do
      user.assign_role role, start_date, end_date
    end

    context 'user has a current function' do
      let(:start_date) { DateTime.now - 10.days }
      let(:end_date) { DateTime.now + 2.days }

      it 'returns the current function' do
        expect(user.current_functions.first.name).to eq(role.name)
      end
    end

    context 'user was in function' do
      let(:start_date) { DateTime.now - 10.days }
      let(:end_date) { DateTime.now - 2.days }

      it 'returns nil' do
        expect(user.current_functions).to eq([])
      end
    end
  end

  describe '#address' do
    it 'user references to address' do
      expect(user.address)
    end

    it 'user address can be assigned' do
      address = create :address
      user.address = address
      expect(user.save).to be_truthy
      expect(user.reload.address).to eq(address)
    end
  end

  describe '#player?' do
    let(:player_profile) { build :player }

    it 'returns true if user has a player relation' do
      user.player = player_profile
      user.save
      expect(user.reload.player?).to be_truthy
    end

    it 'returns false if user has no player assigned' do
      expect(user.reload.player?).to be_falsy
    end
  end

  describe '#contact' do
    it 'has contact' do
      expect(user.contact)
    end
  end
end
