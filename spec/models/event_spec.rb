require 'rails_helper'

describe Event do
  describe '#friendly_id' do
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

  context 'scopes for future and past' do
    let(:event_count) { 4 }
    before do
      create_list(:event, 5, :future)
      create_list(:event, 5, :past)
      create_list(:event, 3)
    end

    describe '.future' do
      it 'returns the last events reguested for' do
        expect(Event.future(event_count).count).to eq event_count
      end

      it 'order all events by time' do
        future_events = Event.future(event_count)
        check_event_odering(future_events)
      end
    end

    describe '.past' do
      it 'returns the past events reguested for' do
        expect(Event.past(event_count).count).to eq event_count
      end

      it 'order all events by time' do
        past_events = Event.past(event_count)
        check_event_odering(past_events)
      end
    end

    def check_event_odering(event_list)
      temp = event_list.first
      event_list.each do |event|
        expect(event.datetime <= temp.datetime).to be_truthy
        temp = event
      end
    end
  end
end
