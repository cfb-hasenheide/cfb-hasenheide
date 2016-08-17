require 'rails_helper'

describe Team do
  let(:addresses) { create_list :address, 5 }
  let(:team) { create :team }

  describe '#addresses' do
    it 'has many addresses' do
      team.addresses = addresses
      expect(team.save).to be_truthy
    end
  end
end
