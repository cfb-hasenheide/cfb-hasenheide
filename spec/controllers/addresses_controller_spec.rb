require 'rails_helper'

describe AddressesController do

  let(:address) { create :address }

  before { sign_in }

  it 'renders the edit template' do
    get :edit, params: { id: address.id }
    expect(response).to render_template(:edit)
  end

  describe '#update' do
    let(:street) { 'Test street 19'}

    subject do
      put :update, params: { id: address.id, address: { street: street } }
    end

    it 'updates the address' do
      expect do
        subject
      end.to change{ address.reload.street }.to(street)
    end

    it "redirects to player/:id" do
      expect(subject).to redirect_to(player_path(address.addressable))
    end
  end
end
