require 'rails_helper'

RSpec.describe HeightsController, type: :controller do

  before do
    allow_any_instance_of(HeightsController).to receive(:current_user).and_return(user)
  end

  let(:height) { create(:height) }
  let(:user) { height.user }

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
    it "creates a height when information is valid" do
      post :create, params: { height: { measurement: 1.73, measured_at: '22/10/2018' } }

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(heights_path)
    end
  end

end
