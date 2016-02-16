require 'rails_helper'

# NOTE: Follows http://guides.rubyonrails.org/testing.html#testing-your-mailers
describe EventMailer do
  let(:event) { create :event, :other }
  let(:users) { create_list :user, 5 }
  let(:to_user_ids) { users.map(&:id) }

  before { ActionMailer::Base.deliveries.clear }

  describe '#open_replies' do
    subject { EventMailer.open_replies(event.id, to_user_ids: to_user_ids) }

    it 'is getting queued' do
      expect{ subject.deliver_now }
        .to change { ActionMailer::Base.deliveries.count }
        .from(0)
        .to(1)
    end
  end

  describe '#close_replies' do
    subject { EventMailer.close_replies(event.id, to_user_ids: to_user_ids) }

    it 'is getting queued' do
      expect{ subject.deliver_now }
        .to change { ActionMailer::Base.deliveries.count }
        .from(0)
        .to(1)
    end
  end
end
