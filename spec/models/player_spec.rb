require 'rails_helper'

describe Player do
  let(:player) { create :player }

  it 'belongs_to a member' do
    expect(player.member)
  end

  it 'has member_id' do
    expect(player.member_id)
  end
end
