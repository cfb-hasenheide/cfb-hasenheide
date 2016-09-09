require 'rails_helper'

describe Team do
  let(:team) { create :team }

  describe '#addresses' do
    let(:addresses) { create_list :address, 5 }

    it 'has many addresses' do
      team.addresses = addresses
      expect(team.save).to be_truthy
    end
  end

  describe '#players' do
    let(:players) { create_list :player, 4 }

    it 'contains the added player' do
      expect do
        team.players << players
      end.to change{ team.players.count }.from(0).to(players.count)
    end
  end
end
