require 'rails_helper'

RSpec.describe FunctionsController, type: :controller do
  let(:function) { create :function }
  let(:role) { function.role }
  let(:user) { function.user }
  before { sign_in }

  describe "POST #create" do
    let(:function) { build :function }
    let(:create_params) { { function: function.attributes } }

    it "returns http success" do
      post :create, params: create_params
      expect(response).to have_http_status(:redirect)
    end

    it 'creates a function' do
      expect do
        post :create, params: create_params
      end.to change{ Function.count }.by(1)
    end

    it 'creates a function' do
      expect do
        post :create, params: create_params
      end.to change{ user.reload.functions.count }.by(1)
    end
  end

  describe "DELETE #destroy" do
    subject do
      delete :destroy, params: { id: function.id }
    end

    before { function }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'it deletes the function from the datebase' do
      expect { subject }.to change{ Function.count }.by(-1)
    end
  end

  describe 'PUT/PATCH #update' do
    let(:new_vacated_at) { DateTime.now + 700 }

    it 'updates vacated_at' do
      expect do
        put :update, params: { id: function.id,
                               function: { vacated_at: new_vacated_at } }
      end.to change{ function.reload.vacated_at }
    end
  end


  describe 'POST #end_up' do
    it 'sets the vacated_at date to now' do
      expect do
        post :end_up, params: { id: function.id }
      end.to change { function.reload.vacated_at }
    end
  end
end
