require 'rails_helper'

describe MembersController do
  let(:member) { create(:player).member }
  before { sign_in }

  describe '#edit' do
    it 'renders edit form' do
      get :edit, params: { id: member.id }
      expect(response).to render_template(:edit)
    end
  end

  describe '#update' do
    let(:identifier) { '123456789' }
    let(:firstname) { 'Hase' }
    let(:new_date) { Time.zone.today }
    let(:member_param) do
      { identifier: identifier, firstname: firstname,
        lastname: firstname, member_since: new_date,
        date_of_birth: new_date }
    end

    subject do
      put :update, params: { id: member.id, member: member_param }
    end

    it 'updates the identifier' do
      expect do
        subject
      end.to change { member.reload.identifier }.to(identifier)
    end

    it 'updates the firstname' do
      expect { subject }.to change { member.reload.firstname }.to firstname
    end

    it 'updates the lastname' do
      expect { subject }.to change { member.reload.lastname }.to firstname
    end

    it 'updates the member date' do
      expect { subject }.to change { member.reload.member_since }.to new_date
    end

    it 'updates the date of birth' do
      expect { subject }.to change { member.reload.date_of_birth }.to new_date
    end

    it 'redirects to player/:id' do
      expect(subject).to redirect_to(player_path(member.player))
    end
  end
end
