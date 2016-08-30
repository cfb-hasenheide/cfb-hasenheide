require 'rails_helper'

describe ContactsController do
  let(:contact) { create(:member, :with_contact, :with_player).contact }
  before { sign_in }

  describe '#edit' do
    it 'renders edit template' do
      get :edit, params: { id: contact.id }
      expect(response).to render_template(:edit)
    end
  end

  describe '#update' do
    let(:email) { 'Hase@hasenbau.de' }

    subject do
      put :update, params: { id: contact.id, contact: { club_email: email } }
    end

    it 'updates the firstname' do
      expect do
        subject
      end.to change { contact.reload.club_email }.to email
    end

    it 'redirects to player/:id' do
      expect(subject).to redirect_to(player_path(contact.member.player))
    end
  end
end
