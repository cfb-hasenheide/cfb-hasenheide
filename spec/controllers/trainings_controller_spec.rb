require 'rails_helper'

RSpec.describe TrainingsController, type: :controller do
  let(:training) { create(:training) }
  let(:training_params) { { training: attributes_for(:training) } }

  before do
    sign_in
    allow(controller).to receive(:authorize!).and_return(true)
  end

  describe 'POST #create' do
    it 'creates a training' do
      expect { post :create, params: training_params }
        .to change { Training.count }.from(0).to(1)
    end
  end

  describe 'DELETE #destroy' do
    before { training }

    it 'destroys a training' do
      expect { delete :destroy, params: { id: training.id } }
        .to change { Training.count }.from(1).to(0)
    end
  end
end
