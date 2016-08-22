require 'rails_helper'

RSpec.describe FunctionsController, type: :controller do
  let(:function) { create :function, :current }
  let(:role) { function.role }
  let(:user) { function.user }
  before { sign_in }

  describe 'POST #create' do
    let(:function) { build :function, :current }
    let(:create_params) { { function: function.attributes } }
    subject { post :create, params: create_params }

    shared_examples 'create function' do
      it 'creates a function' do
        expect { subject }.to change { Function.count }.by(1)
      end
    end

    shared_examples 'cannot create' do
      it 'does not create the function' do
        expect { subject }.to_not change { Function.count }
      end
    end

    it 'returns http success' do
      post :create, params: create_params
      expect(response).to have_http_status(:redirect)
    end

    it 'is accesable by the user' do
      expect do
        post :create, params: create_params
      end.to change { user.reload.functions.count }.by(1)
    end

    it_behaves_like 'create function'

    context 'create in for same/overlapping time' do
      let(:vacated_at) { function.vacated_at }
      let(:assumed_at) { function.assumed_at }
      let(:to_create_function) do
        build(:function,
              user: user, role: role,
              vacated_at: vacated_at, assumed_at: assumed_at).attributes
      end

      subject do
        post :create, params: { function: to_create_function }
      end

      before { post :create, params: create_params }

      context 'examct same function' do
        it_behaves_like 'cannot create'
      end

      context 'overlapping time by assumed_at' do
        let(:assumed_at) { function.assumed_at + 1 }
        it_behaves_like 'cannot create'
      end

      context 'overlapping time by vacated_at' do
        let(:vacated_at) { function.vacated_at + 2 }
        it_behaves_like 'cannot create'
      end

      context 'time in the middle of existing' do
        let(:assumed_at) { function.assumed_at + 1 }
        let(:vacated_at) { function.vacated_at - 1 }
        it_behaves_like 'cannot create'
      end

      context 'different and independent time' do
        let(:assumed_at) { Time.zone.today + 1000 }
        let(:vacated_at) { Time.zone.today + 1003 }
        it_behaves_like 'create function'
      end
    end
  end

  describe 'DELETE #destroy' do
    subject do
      delete :destroy, params: { id: function.id }
    end

    before { function }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'it deletes the function from the datebase' do
      expect { subject }.to change { Function.count }.by(-1)
    end
  end

  describe 'PUT/PATCH #update' do
    let(:new_vacated_at) { Time.zone.now + 700 }

    it 'updates vacated_at' do
      expect do
        put :update, params: { id: function.id,
                               function: { vacated_at: new_vacated_at } }
      end.to change { function.reload.vacated_at }
    end
  end

  describe 'POST #end_up' do
    it 'sets the vacated_at date to todays date' do
      expect do
        post :end_up, params: { id: function.id }
      end.to change { function.reload.vacated_at }
    end
  end
end
