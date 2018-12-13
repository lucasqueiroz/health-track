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
    let(:new_measurement) { Faker::Number.between(1.00, 2.00).to_f.round(2) }
    let(:new_measured_at) { Faker::Date.between(6.years.ago, Date.today) }
    let(:new_height) { { height: { measurement: new_measurement, measured_at: new_measured_at } } }

    it "creates a height when information is valid" do
      post :create, params: new_height

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(heights_path)
    end

    context "when saving fails" do
      before do
        allow_any_instance_of(Height).to receive(:save).and_return(false)
        post :create, params: new_height
      end

      it "renders the new height page" do
        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, params: { id: height.id }
      expect(response).to have_http_status(:success)
    end

    context "when user is not logged in" do
      before do
        allow_any_instance_of(SessionsHelper).to receive(:logged_in?).and_return(false)
        get :edit, params: { id: height.id }
      end

      it "redirects user to login page" do
        expect(response).to redirect_to(login_path)
        expect(flash).not_to be_empty
      end
    end
  end

  describe "POST #update" do
    let(:new_measurement) { Faker::Number.between(1.00, 2.00).to_f.round(2) }

    it "edits a height when information is valid" do
      patch :update, params: { id: height.id, height: { measurement: new_measurement } }

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(heights_path)
      expect(Height.last.measurement).to eq(new_measurement)
    end

    context "when updating fails" do
      before do
        allow_any_instance_of(Height).to receive(:update).and_return(false)
        patch :update, params: { id: height.id, height: { measurement: new_measurement } }
      end

      it "renders the edit height page" do
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys a height" do
      delete :destroy, params: { id: height.id }

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(heights_path)
      expect(flash).not_to be_empty
    end
  end

end
