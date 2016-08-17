require 'rails_helper'

describe Player do
  let(:user) { create :user, :as_player }
  let(:player) { user.player }

  describe '#address' do
    it 'has an address' do
      expect(user.address)
    end
  end

  describe '#contact' do
    it 'has contact' do
      expect(player.contact)
    end
  end
end
