require 'rails_helper'

RSpec.describe Api::HeightsController, type: :controller do
  include ApiSpecHelper

  before do
    controller.request.env['HTTP_AUTHORIZATION'] = basic_auth(user.email, user.password)
  end

  let!(:height) { create(:height) }
  let!(:different_height) { create(:different_height) }
  let(:user) { height.user }
  let(:different_user) { different_height.user }
  let(:third_user) { create(:third_user) }

  describe "GET #index" do
    before do
      get :index
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "returns valid JSON body" do
      expect(json).not_to be_empty
      expect(json.size).to eq(1)
      expect(json[0]['user_id']).to eq(height.user.id)
    end
  end

  describe "GET #show" do
    before do
      get :show, params: { id: height.id }
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "returns valid JSON body" do
      expect(json).not_to be_empty
      expect(json['user_id']).to eq(height.user_id)
    end

    context "when user is not the owner of the resource" do
      before do
        controller.request.env['HTTP_AUTHORIZATION'] = basic_auth(different_user.email, different_user.password)
        get :show, params: { id: height.id }
      end

      it "returns http not found" do
        expect(response).to have_http_status(:not_found)
      end

      it "returns valid JSON body" do
        expect(json).not_to be_empty
        expect(json['errors']).not_to be_empty
        expect(json['errors']).to include('Not found!')
      end
    end

    context "when resource does not exist" do
      before do
        get :show, params: { id: Height.last.id + 1 }
      end

      it "returns http not found" do
        expect(response).to have_http_status(:not_found)
      end

      it "returns valid JSON body" do
        expect(json).not_to be_empty
        expect(json['errors']).not_to be_empty
        expect(json['errors']).to include('Not found!')
      end
    end

    context "when user is not authorized" do
      before do
        controller.request.env['HTTP_AUTHORIZATION'] = basic_auth('email', 'password')
        get :show, params: { id: height.id }
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "returns valid JSON body" do
        expect(json).not_to be_empty
        expect(json['errors']).not_to be_empty
        expect(json['errors']).to include('User not authorized!')
      end
    end
  end

  describe "POST #create" do
    let(:new_measurement) { Faker::Number.between(1.00, 2.00).to_f.round(2) }
    let(:new_measured_at) { Faker::Date.between(6.years.ago, Date.today) }
    let(:new_height) { { height: { measurement: new_measurement, measured_at: new_measured_at } } }

    context "when height is valid" do
      before do
        post :create, params: new_height
      end

      it "returns http success" do
        expect(response).to have_http_status(:ok)
      end

      it "returns valid JSON body" do
        expect(json).not_to be_empty
        expect(json['measurement']).to eq(new_measurement)
        expect(json['measured_at']).to eq(new_measured_at.to_s)
      end
    end

    context "when user is not authorized" do
      before do
        controller.request.env['HTTP_AUTHORIZATION'] = basic_auth('email', 'password')
        post :create, params: new_height
      end

      it "returns http success" do
        expect(response).to have_http_status(:ok)
      end

      it "returns valid JSON body" do
        expect(json).not_to be_empty
        expect(json['errors']).not_to be_empty
        expect(json['errors']).to include('User not authorized!')
      end
    end

    context "when saving fails" do
      before do
        allow_any_instance_of(Height).to receive(:save).and_return(false)
        post :create, params: new_height
      end

      it "returns error JSON" do
        expect(json).not_to be_empty
        expect(json).to have_key('errors')
      end
    end
  end

  describe "PATCH #update" do
    let(:new_measurement) { Faker::Number.between(1.00, 2.00).to_f.round(2) }

    context "when updated information is valid" do
      before do
        patch :update, params: { id: height.id, height: { measurement: new_measurement } }
      end

      it "returns http success" do
        expect(response).to have_http_status(:ok)
      end

      it "returns valid JSON body" do
        expect(json).not_to be_empty
        expect(json['measurement']).to eq(new_measurement)
        expect(json['measured_at']).to eq(height.measured_at.to_s)
      end
    end

    context "when updated information is invalid" do
      let(:new_measurement) { Faker::Number.between(-2.00, -1.00).to_f.round(2) }

      before do
        patch :update, params: { id: height.id, height: { measurement: new_measurement } }
      end

      it "returns http success" do
        expect(response).to have_http_status(:ok)
      end

      it "returns valid JSON body" do
        expect(json).not_to be_empty
        expect(json['errors']).not_to be_empty
      end
    end

    context "when user is not the owner of the resource" do
      before do
        controller.request.env['HTTP_AUTHORIZATION'] = basic_auth(different_user.email, different_user.password)
        patch :update, params: { id: height.id, height: { measurement: new_measurement } }
      end

      it "returns http not found" do
        expect(response).to have_http_status(:not_found)
      end

      it "returns valid JSON body" do
        expect(json).not_to be_empty
        expect(json['errors']).not_to be_empty
        expect(json['errors']).to include('Not found!')
      end
    end

    context "when user is not authorized" do
      before do
        controller.request.env['HTTP_AUTHORIZATION'] = basic_auth('email', 'password')
        patch :update, params: { id: height.id, height: { measurement: new_measurement } }
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "returns valid JSON body" do
        expect(json).not_to be_empty
        expect(json['errors']).not_to be_empty
        expect(json['errors']).to include('User not authorized!')
      end
    end

    context "when resource does not exist" do
      before do
        patch :update, params: { id: Height.last.id + 1, height: { measurement: new_measurement } }
      end

      it "returns http not found" do
        expect(response).to have_http_status(:not_found)
      end

      it "returns valid JSON body" do
        expect(json).not_to be_empty
        expect(json['errors']).not_to be_empty
        expect(json['errors']).to include('Not found!')
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      delete :destroy, params: { id: height.id }
    end

    it "returns http no content" do
      expect(response).to have_http_status(:no_content)
    end

    context "when user is not the owner of the resource" do
      before do
        controller.request.env['HTTP_AUTHORIZATION'] = basic_auth(third_user.email, third_user.password)
        delete :destroy, params: { id: different_height.id }
      end

      it "returns http not found" do
        expect(response).to have_http_status(:not_found)
      end

      it "returns valid JSON body" do
        expect(json).not_to be_empty
        expect(json['errors']).not_to be_empty
        expect(json['errors']).to include('Not found!')
      end
    end

    context "when user is not authorized" do
      before do
        controller.request.env['HTTP_AUTHORIZATION'] = basic_auth('email', 'password')
        delete :destroy, params: { id: different_height.id }
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "returns valid JSON body" do
        expect(json).not_to be_empty
        expect(json['errors']).not_to be_empty
        expect(json['errors']).to include('User not authorized!')
      end
    end

    context "when resource does not exist" do
      before do
        delete :destroy, params: { id: height.id }
      end

      it "returns http not found" do
        expect(response).to have_http_status(:not_found)
      end

      it "returns valid JSON body" do
        expect(json).not_to be_empty
        expect(json['errors']).not_to be_empty
        expect(json['errors']).to include('Not found!')
      end
    end
  end
end
