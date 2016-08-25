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
      let(:vacated_on) { function.vacated_on }
      let(:assumed_on) { function.assumed_on }
      let(:to_create_function) do
        build(:function,
              user: user, role: role,
              vacated_on: vacated_on, assumed_on: assumed_on).attributes
      end

      subject do
        post :create, params: { function: to_create_function }
      end

      before { post :create, params: create_params }

      context 'examct same function' do
        it_behaves_like 'cannot create'
      end

      context 'overlapping time by assumed_on' do
        let(:assumed_on) { function.assumed_on + 1 }
        it_behaves_like 'cannot create'
      end

      context 'overlapping time by vacated_on' do
        let(:vacated_on) { function.vacated_on + 2 }
        it_behaves_like 'cannot create'
      end

      context 'time in the middle of existing' do
        let(:assumed_on) { function.assumed_on + 1 }
        let(:vacated_on) { function.vacated_on - 1 }
        it_behaves_like 'cannot create'
      end

      context 'different and independent time' do
        let(:assumed_on) { Time.zone.today + 1000 }
        let(:vacated_on) { Time.zone.today + 1003 }
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
    let(:new_vacated_on) { function.vacated_on + 700 }

    it 'updates vacated_on' do
      expect do
        put :update, params: { id: function.id,
                               function: { vacated_on: new_vacated_on } }
      end.to change { function.reload.vacated_on }
    end
  end
end
