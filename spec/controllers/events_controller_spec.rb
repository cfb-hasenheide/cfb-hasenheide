require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  let(:event) { FactoryGirl.create :event }
  let(:valid_attributes) do
    skip('Add a hash of attributes valid for your model')
  end

  let(:invalid_attributes) do
    skip('Add a hash of attributes invalid for your model')
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
      get :edit,  id: event.id
      expect(assigns(:event).id).to eq(event.id)
    end
  end

  describe 'POST create' do
    context 'with valid params' do
      it 'creates a new Event' do
        expect do
          post :create, { event: valid_attributes }, valid_session
        end.to change(Event, :count).by(1)
      end

      it 'assigns a newly created event as @event' do
        post :create, { event: valid_attributes }, valid_session
        expect(assigns(:event)).to be_a(Event)
        expect(assigns(:event)).to be_persisted
      end

      it 'redirects to the created event' do
        post :create, { event: valid_attributes }, valid_session
        expect(response).to redirect_to(Event.last)
      end
    end

    describe 'with invalid params' do
      it 'assigns a newly created but unsaved event as @event' do
        post :create, { event: invalid_attributes }, valid_session
        expect(assigns(:event)).to be_a_new(Event)
      end

      it "re-renders the 'new' template" do
        post :create, { event: invalid_attributes }, valid_session
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT update' do
    describe 'with valid params' do
      let(:new_attributes) do
        skip('Add a hash of attributes valid for your model')
      end

      it 'updates the requested event' do
        event = Event.create! valid_attributes
        put :update,
            { id: event.to_param, event: new_attributes },
            valid_session
        event.reload
        skip('Add assertions for updated state')
      end

      it 'assigns the requested event as @event' do
        event = Event.create! valid_attributes
        put :update,
            { id: event.to_param, event: valid_attributes },
            valid_session
        expect(assigns(:event)).to eq(event)
      end

      it 'redirects to the event' do
        event = Event.create! valid_attributes
        put :update,
            { id: event.to_param, event: valid_attributes },
            valid_session
        expect(response).to redirect_to(event)
      end
    end

    describe 'with invalid params' do
      it 'assigns the event as @event' do
        event = Event.create! valid_attributes
        put :update,
            { id: event.to_param, event: invalid_attributes },
            valid_session
        expect(assigns(:event)).to eq(event)
      end

      it "re-renders the 'edit' template" do
        event = Event.create! valid_attributes
        put :update,
            { id: event.to_param, event: invalid_attributes },
            valid_session
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE destroy' do
    it 'destroys the requested event' do
      event = Event.create! valid_attributes
      expect do
        delete :destroy, { id: event.to_param }, valid_session
      end.to change(Event, :count).by(-1)
    end

    it 'redirects to the events list' do
      event = Event.create! valid_attributes
      delete :destroy, { id: event.to_param }, valid_session
      expect(response).to redirect_to(events_url)
    end
  end
end
