require 'rails_helper'

RSpec.describe Api::WorkoutsController, type: :controller do
  include ApiSpecHelper

  before do
    controller.request.env['HTTP_AUTHORIZATION'] = basic_auth(user.email, user.password)
  end

  let!(:workout) { create(:workout) }
  let!(:different_workout) { create(:different_workout) }
  let(:user) { workout.user }
  let(:different_user) { different_workout.user }
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

  describe "POST #create" do
    let(:new_name) { Faker::Name.first_name }
    let(:new_calories) { Faker::Number.between(100, 1000).to_i }
    let(:new_occurred_at) { Faker::Date.between(6.years.ago, Date.today) }
    let(:new_workout) { { workout: { name: new_name, calories: new_calories, occurred_at: new_occurred_at } } }

    context "when workout is valid" do
      before do
        post :create, params: new_workout
      end

      it "returns http success" do
        expect(response).to have_http_status(:ok)
      end

      it "returns valid JSON body" do
        expect(json).not_to be_empty
        expect(json['name']).to eq(new_name)
        expect(json['calories']).to eq(new_calories)
        expect(json['occurred_at']).to eq(new_occurred_at.to_s)
      end
    end

    context "when user is not authorized" do
      before do
        controller.request.env['HTTP_AUTHORIZATION'] = basic_auth('email', 'password')
        post :create, params: new_workout
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
        allow_any_instance_of(Workout).to receive(:save).and_return(false)
        post :create, params: new_workout
      end

      it "returns error JSON" do
        expect(json).not_to be_empty
        expect(json).to have_key('errors')
      end
    end
  end

  describe "PATCH #update" do
    let(:new_calories) { Faker::Number.between(100, 1000).to_i }

    context "when updated information is valid" do
      before do
        patch :update, params: { id: workout.id, workout: { calories: new_calories } }
      end

      it "returns http success" do
        expect(response).to have_http_status(:ok)
      end

      it "returns valid JSON body" do
        expect(json).not_to be_empty
        expect(json['name']).to eq(workout.name)
        expect(json['calories']).to eq(new_calories)
        expect(json['occurred_at']).to eq(workout.occurred_at.to_s)
      end
    end

    context "when updated information is invalid" do
      let(:new_calories) { Faker::Number.between(-1000, -100).to_i }
      before do
        patch :update, params: { id: workout.id, workout: { calories: new_calories } }
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
        patch :update, params: { id: workout.id, workout: { calories: new_calories } }
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
        patch :update, params: { id: workout.id, workout: { calories: new_calories } }
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
        patch :update, params: { id: Workout.last.id + 1, workout: { calories: new_calories } }
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
      delete :destroy, params: { id: workout.id }
    end

    it "returns http no content" do
      expect(response).to have_http_status(:no_content)
    end

    context "when user is not the owner of the resource" do
      before do
        controller.request.env['HTTP_AUTHORIZATION'] = basic_auth(third_user.email, third_user.password)
        delete :destroy, params: { id: different_workout.id }
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
        delete :destroy, params: { id: different_workout.id }
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
        delete :destroy, params: { id: workout.id }
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
