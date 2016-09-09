require 'rails_helper'

RSpec.describe TeamPlayersController, type: :controller do
  let(:team) { create :team }

  before do
    sign_in
    allow(controller).to receive(:authorize_admin!) { true }
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, params: { team_id: team.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #update" do
    let(:players) { create_list :player, 4 }
    let(:player_ids) { players.map { |p| p.id } }
    subject do
      get :update, params: { team_id: team.id, player_ids: player_ids }
    end

    it "returns http success" do
      subject
      expect(response).to have_http_status(:redirect)
    end

    it 'update a team with given player_ids' do
      expect do
        subject
      end.to change { team.players.count }.from(0).to(players.count)
    end

    context 'player exists' do
      before { subject }

      it 'throws no error' do
        expect { subject }.not_to raise_error
      end

      it 'keeps players for team' do
        expect { subject }.not_to change{ team.players.count }
      end

      it 'adds all not existing players' do
        new_player = create :player
        player_ids << new_player.id
        expect do
          get :update, params: { team_id: team.id, player_ids: player_ids }
        end.to change{ team.players.count }
          .from(players.count).to(players.count + 1)
      end
    end
  end
end
