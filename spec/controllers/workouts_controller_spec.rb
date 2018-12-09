require 'rails_helper'

RSpec.describe WorkoutsController, type: :controller do

  before do
    allow_any_instance_of(WorkoutsController).to receive(:current_user).and_return(user)
  end

  let(:workout) { create(:workout) }
  let(:user) { workout.user }

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
    it "creates a workout when information is valid" do
      post :create, params: { workout: { name: 'Running', calories: 500, occurred_at: '22/10/2018' } }

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(workouts_path)
    end
  end

  describe "#GET edit" do
    it "returns http success" do
      get :edit, params: { id: workout.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "#POST update" do
    it "edits a workout when information is valid" do
      patch :update, params: { id: workout.id, workout: { name: 'Running', calories: 550, occurred_at: '22/10/2018' } }

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(workouts_path)
      expect(Workout.last.calories).to eq(550)
    end
  end

  describe "#DELETE destroy" do
    it "destroys a workout" do
      delete :destroy, params: { id: workout.id }

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(workouts_path)
      expect(flash).not_to be_empty
    end
  end

end
