require 'rails_helper'

RSpec.describe FunctionsController, type: :controller do
  let(:function) { build :function }
  let(:role) { function.role }
  let(:user) { function.user }
  before { sign_in }

  describe "POST #create" do
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
    let!(:persited_funciton) { create :function }

    subject do
      delete :destroy, params: { id: persited_funciton.id }
    end

    it "returns http success" do
      delete :destroy, params: { id: persited_funciton.id }
      expect(response).to have_http_status(:success)
    end

    it "does not delete the entry from the database" do
      expect { subject }.to_not change{ Function.count }
    end

    it 'represents a deleted function by setting the vacated_at date' do
      expect do
        subject
      end.to change{ persited_funciton.reload.vacated_at }
    end
  end
end
