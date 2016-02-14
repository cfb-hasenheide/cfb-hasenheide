require 'rails_helper'

describe User do
  context 'after create' do
    it 'creates its UserProfile' do
      expect { create :user }.to change { UserProfile.count }.from(0).to(1)
    end
  end

  context 'after destroy' do
    let!(:user) { create :user }

    it 'destroys its UserProfile' do
      expect { user.destroy }.to change { UserProfile.count }.from(1).to(0)
    end
  end
end
