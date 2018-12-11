require 'rails_helper'

RSpec.describe Api::HeightsController, type: :controller do
  include ApiSpecHelper

  before do
    controller.request.env['HTTP_AUTHORIZATION'] = basic_auth(user.email, user.password)
  end

  let!(:height) { create(:height) }
  let(:user) { build(:user) }
  let(:different_user) { create(:different_user) }

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
    context "when height is valid" do
      before do
        post :create, params: { height: { measurement: 1.75, measured_at: '22/10/2018' } }
      end

      it "returns http success" do
        expect(response).to have_http_status(:ok)
      end

      it "returns valid JSON body" do
        expect(json).not_to be_empty
        expect(json['measurement']).to eq(1.75)
        expect(json['measured_at']).to eq('2018-10-22')
      end
    end

    context "when user is not authorized" do
      before do
        controller.request.env['HTTP_AUTHORIZATION'] = basic_auth('email', 'password')
        post :create, params: { height: { measurement: 1.75, measured_at: '22/10/2018' } }
      end

      it "returns http success" do
        expect(response).to have_http_status(:ok)
      end

      it "returns valid JSON body" do
        p json
        expect(json).not_to be_empty
        expect(json['errors']).not_to be_empty
        expect(json['errors']).to include('User not authorized!')
      end
    end
  end

  describe "PATCH #update" do
    context "when updated information is valid" do
      before do
        patch :update, params: { id: height.id, height: { measurement: 1.89 } }
      end

      it "returns http success" do
        expect(response).to have_http_status(:ok)
      end

      it "returns valid JSON body" do
        expect(json).not_to be_empty
        expect(json['measurement']).to eq(1.89)
        expect(json['measured_at']).to eq(height.measured_at.to_s)
      end
    end

    context "when updated information is invalid" do
      before do
        patch :update, params: { id: height.id, height: { measurement: -1 } }
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
        patch :update, params: { id: height.id, height: { measurement: 1.89 } }
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
        patch :update, params: { id: height.id, height: { measurement: 1.89 } }
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
        patch :update, params: { id: Height.last.id + 1, height: { measurement: 1.89 } }
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
