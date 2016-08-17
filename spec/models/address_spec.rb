require 'rails_helper'

RSpec.describe Address, type: :model do
  describe '#all' do
    let(:created_count) { 15 }

    before do
      create_list :address, created_count
    end

    it 'returns all addresses' do
      expect(Address.all.count).to eq(created_count)
    end
  end

  describe '#addressable' do
    let(:address) { create :address }

    it 'returns the user' do
      user = create :user
      user.address = address and user.save
      expect(address.addressable).to eq(user)
    end

    it 'returns the team' do
      team = create :team
      team.addresses << address and team.save
      expect(address.addressable).to eq(team)
    end
  end
end
