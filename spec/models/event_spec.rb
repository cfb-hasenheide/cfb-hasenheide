require 'rails_helper'

describe Event do
  context '#friendly_id' do
    let(:name) { 'Event A' }
    let(:event) { create :event, name: name }

    it 'has the correct friendly_id' do
      expect(event.friendly_id).to eq 'event-a'
    end

    it 'has a changed friendly_id if name changes' do
      expect { event.update(name: 'Event B') }
        .to change { event.friendly_id }
        .from('event-a')
        .to('event-b')
    end
  end
end
