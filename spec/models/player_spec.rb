require 'rails_helper'

describe Player do
  let(:player) { create :player }

  it 'belongs_to a member' do
    expect(player.member)
  end

  it 'has member_id' do
    expect(player.member_id)
  end

  describe '#teams' do
    let(:teams) { create_list :team, 2 }

    it 'can be assigned to a teams' do
      expect do
        player.teams << teams
      end.to change{ player.reload.teams.count }.from(0).to(teams.count)
    end
  end
end
