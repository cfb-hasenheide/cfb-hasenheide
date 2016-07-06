require 'rails_helper'

# NOTE: Follows http://guides.rubyonrails.org/testing.html#testing-your-mailers
describe EventMailer do
  let(:event) { create :event, :other }
  let(:users) { create_list :user, 5 }
  let(:to_player_ids) { users.map(&:id) }

  before { ActionMailer::Base.deliveries.clear }

  describe '#attendance_list_opened' do
    subject do
      EventMailer.attendance_list_opened(event.id, to_player_ids: to_player_ids)
    end

    it 'is getting queued' do
      expect { subject.deliver_now }
        .to change { ActionMailer::Base.deliveries.count }
        .from(0)
        .to(1)
    end
  end

  describe '#attendance_list_closed' do
    subject do
      EventMailer.attendance_list_closed(event.id, to_player_ids: to_player_ids)
    end

    it 'is getting queued' do
      expect { subject.deliver_now }
        .to change { ActionMailer::Base.deliveries.count }
        .from(0)
        .to(1)
    end
  end
end
