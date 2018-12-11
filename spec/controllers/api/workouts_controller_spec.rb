require 'rails_helper'

RSpec.describe Api::WorkoutsController, type: :controller do
  include ApiSpecHelper

  before do
    controller.request.env['HTTP_AUTHORIZATION'] = basic_auth(user.email, user.password)
  end

  let!(:workout) { create(:workout) }
  let!(:different_workout) { create(:different_workout) }
  let(:user) { build(:user) }
  let(:different_user) { build(:different_user) }
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
      expect(json[0]['user_id']).to eq(workout.user.id)
    end
  end

  describe "GET #show" do
    before do
      get :show, params: { id: workout.id }
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "returns valid JSON body" do
      expect(json).not_to be_empty
      expect(json['user_id']).to eq(workout.user_id)
    end

    context "when user is not the owner of the resource" do
      before do
        controller.request.env['HTTP_AUTHORIZATION'] = basic_auth(different_user.email, different_user.password)
        get :show, params: { id: workout.id }
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
        get :show, params: { id: Workout.last.id + 1 }
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
        get :show, params: { id: workout.id }
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
end
