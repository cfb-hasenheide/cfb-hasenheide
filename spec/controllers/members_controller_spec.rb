require 'rails_helper'

describe MembersController do
  let(:member) { create(:member) }
  before { sign_in }

  describe '#edit' do
    it 'renders edit form' do
      get :edit, params: { id: member.id }
      expect(response).to render_template(:edit)
    end
  end

  describe '#update' do
    let(:identifier) { '123456789' }
    subject do
      put :update, params: { id: member.id, member: { identifier: identifier } }
    end

    it 'updates the identifier' do
      expect do
        subject
      end.to change { member.reload.identifier }.to(identifier)
    end

    it 'redirects to player/:id' do
      expect(subject).to redirect_to(player_path(member.player))
    end
  end
end
