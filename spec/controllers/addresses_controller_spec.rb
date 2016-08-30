require 'rails_helper'

describe AddressesController do
  let(:address) { create(:member, :with_player, :with_address).address }

  before { sign_in }

  it 'renders the edit template' do
    get :edit, params: { id: address.id }
    expect(response).to render_template(:edit)
  end

  describe '#update' do
    let(:street) { 'Test street 19' }
    let(:zipcode) { '12222' }
    let(:city) { 'Hasenstadt' }

    let(:address_param) do
      {
        street: street,
        zipcode: zipcode,
        city: city
      }
    end

    subject do
      put :update, params: { id: address.id, address: address_param }
    end

    it 'updates the address' do
      expect do
        subject
      end.to change { address.reload.street }.to(street)
    end

    it 'updates the zipcode' do
      expect do
        subject
      end.to change { address.reload.zipcode }.to(zipcode)
    end

    it 'updates the zipcode' do
      expect do
        subject
      end.to change { address.reload.city }.to(city)
    end

    it 'redirects to player/:id' do
      expect(subject).to redirect_to(player_path(address.addressable.player))
    end
  end
end
