require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  let(:event) { create :event }
  let(:event_attr) { attributes_for :event }

  let(:valid_attributes) do
    event_attr[:club_team_id] = create(:team, :club).id
    event_attr[:rival_team_id] = create(:team, :rival).id
    event_attr
  end

  let(:invalid_attributes) do
    event_attr[:club_team_id] = nil
    event_attr
  end

  before(:each) do
    sign_in
    allow(controller).to receive(:authorize_admin!) { true }
  end

  describe 'GET index' do
    it 'assigns all events as @events' do
      event
      get :index
      expect(assigns(:events).count).to eq(Event.count)
    end
  end

  describe 'GET show' do
    it 'assigns the requested event as @event' do
      skip 'look up in controller for user usage'
      event
      get :show, id: event.id
      expect(assigns(:event)).to eq(event)
    end
  end

  describe 'GET new' do
    it 'assigns a new event as @event' do
      type_of_event = 'CupMatch'
      get :new, type: type_of_event
      expect(assigns(:event)).to be_a_new(Event)
      expect(assigns(:event).type).to eq type_of_event
    end
  end

  describe 'GET edit' do
    it 'assigns the requested event as @event' do
      get :edit, id: event.id
      expect(assigns(:event).id).to eq(event.id)
    end
  end

  describe 'POST create' do
    context 'with valid params' do
      it 'assigns a newly created event as @event' do
        post :create, event: valid_attributes
        expect(assigns(:event)).to be_a(Event)
        expect(assigns(:event)).to be_persisted
      end

      it 'creates a new Event' do
        expect do
          post :create, event: valid_attributes
        end.to change { Event.count }.from(0).to(1)
      end

      it 'redirects to the created event' do
        post :create, event: valid_attributes
        expect(response).to redirect_to(Event.last)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved event as @event' do
        post :create, event: invalid_attributes
        expect(assigns(:event)).to be_a_new(Event)
      end

      it "re-renders the 'new' template" do
        post :create, event: invalid_attributes
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT update' do
    context 'with valid params' do
      let(:new_min) { 10 }
      let(:new_attributes) do
        valid_attributes[:minimum] = new_min
        valid_attributes
      end

      it 'updates the requested event' do
        expect do
          put :update, id: event.id, event: new_attributes
        end.to change { event.reload.minimum }.from(event.minimum).to(new_min)
      end

      it 'redirects to the event' do
        put :update, id: event.id, event: valid_attributes
        expect(response).to redirect_to(event)
      end
    end

    context 'with invalid params' do
      it "re-renders the 'edit' template" do
        put :update, id: event.id, event: invalid_attributes
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE destroy' do
    it 'destroys the requested event' do
      event
      expect do
        delete :destroy, id: event.id
      end.to change { Event.count }.from(1).to(0)
    end

    it 'redirects to the events list' do
      event
      delete :destroy, id: event.id
      expect(response).to redirect_to(events_url)
    end
  end
end
