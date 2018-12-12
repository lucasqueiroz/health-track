require 'rails_helper'

RSpec.describe WeightsController, type: :controller do

  before do
    allow_any_instance_of(WeightsController).to receive(:current_user).and_return(user)
  end

  let(:weight) { create(:weight) }
  let(:user) { weight.user }

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    it "creates a weight when information is valid" do
      post :create, params: { weight: { measurement: 25, measured_at: '22/10/2018' } }

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(weights_path)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, params: { id: weight.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #update" do
    it "edits a weight when information is valid" do
      patch :update, params: { id: weight.id, weight: { measurement: 100, measured_at: '22/10/2018' } }

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(weights_path)
      expect(Weight.last.measurement).to eq(100)
    end
  end

  describe "DELETE #destroy" do
    it "destroys a weight" do
      delete :destroy, params: { id: weight.id }

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(weights_path)
      expect(flash).not_to be_empty
    end
  end

end
