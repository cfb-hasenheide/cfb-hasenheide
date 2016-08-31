require 'rails_helper'

RSpec.describe Contact, type: :model do
  let(:contact) { create :contact }

  it 'has a member relation' do
    expect(contact.member)
  end
end
