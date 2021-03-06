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

    context "when user is not logged in" do
      before do
        allow_any_instance_of(SessionsHelper).to receive(:logged_in?).and_return(false)
        get :index
      end

      it "redirects user to login page" do
        expect(response).to redirect_to(login_path)
        expect(flash).not_to be_empty
      end
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    context "when user is not logged in" do
      before do
        allow_any_instance_of(SessionsHelper).to receive(:logged_in?).and_return(false)
        get :new
      end

      it "redirects user to login page" do
        expect(response).to redirect_to(login_path)
        expect(flash).not_to be_empty
      end
    end
  end

  describe "POST #create" do
    let(:new_measurement) { Faker::Number.between(70, 100).to_i }
    let(:new_measured_at) { Faker::Date.between(6.years.ago, Date.today) }
    let(:new_weight) { { weight: { measurement: new_measurement, measured_at: new_measured_at } } }

    it "creates a weight when information is valid" do
      post :create, params: new_weight

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(weights_path)
    end

    context "when saving fails" do
      before do
        allow_any_instance_of(Weight).to receive(:save).and_return(false)
        post :create, params: new_weight
      end

      it "renders the new weight page" do
        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, params: { id: weight.id }
      expect(response).to have_http_status(:success)
    end

    context "when user is not logged in" do
      before do
        allow_any_instance_of(SessionsHelper).to receive(:logged_in?).and_return(false)
        get :edit, params: { id: weight.id }
      end

      it "redirects user to login page" do
        expect(response).to redirect_to(login_path)
        expect(flash).not_to be_empty
      end
    end
  end

  describe "POST #update" do
    let(:new_measurement) { Faker::Number.between(70, 100).to_i }

    it "edits a weight when information is valid" do
      patch :update, params: { id: weight.id, weight: { measurement: new_measurement } }

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(weights_path)
      expect(Weight.last.measurement).to eq(new_measurement)
    end

    context "when updating fails" do
      before do
        allow_any_instance_of(Weight).to receive(:update).and_return(false)
        patch :update, params: { id: weight.id, weight: { measurement: new_measurement } }
      end

      it "renders the edit weight page" do
        expect(response).to render_template(:edit)
      end
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
