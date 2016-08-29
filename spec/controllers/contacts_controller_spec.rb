require 'rails_helper'

describe ContactsController do
  let(:contact) { create :contact }
  before { sign_in }

  describe '#edit' do
    it 'renders edit template' do
      get :edit, params: { id: contact.id }
      expect(response).to render_template(:edit)
    end
  end

  describe '#update' do
    let(:firstname) { 'Hase' }

    subject do
      put :update, params: { id: contact.id, contact: { firstname: firstname } }
    end

    it 'updates the firstname' do
      expect do
        subject
      end.to change { contact.reload.firstname }.to firstname
    end

    it 'redirects to player/:id' do
      expect(subject).to redirect_to(player_path(contact.player))
    end
  end
end
