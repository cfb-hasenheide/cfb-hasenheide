require 'rails_helper'

RSpec.describe Member, type: :model do
  let(:user) { create(:user, :as_member) }
  let(:member) { user.member }

  describe '#user' do
    it 'has user relation' do
      expect(member.user).to eq(user)
    end
  end
end