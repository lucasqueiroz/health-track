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
    let(:new_name) { Faker::Name.first_name }
    let(:new_calories) { Faker::Number.between(100, 1000).to_i }
    let(:new_occurred_at) { Faker::Date.between(6.years.ago, Date.today) }
    let(:new_workout) { { workout: { name: new_name, calories: new_calories, occurred_at: new_occurred_at } } }

    it "creates a workout when information is valid" do
      post :create, params: new_workout

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(workouts_path)
    end

    context "when saving fails" do
      before do
        allow_any_instance_of(Workout).to receive(:save).and_return(false)
        post :create, params: new_workout
      end

      it "renders the new workout page" do
        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, params: { id: workout.id }
      expect(response).to have_http_status(:success)
    end

    context "when user is not logged in" do
      before do
        allow_any_instance_of(SessionsHelper).to receive(:logged_in?).and_return(false)
        get :edit, params: { id: workout.id }
      end

      it "redirects user to login page" do
        expect(response).to redirect_to(login_path)
        expect(flash).not_to be_empty
      end
    end
  end

  describe "POST #update" do
    let(:new_calories) { Faker::Number.between(100, 1000).to_i }

    it "edits a workout when information is valid" do
      patch :update, params: { id: workout.id, workout: { calories: new_calories } }

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(workouts_path)
      expect(Workout.last.calories).to eq(new_calories)
    end

    context "when updating fails" do
      before do
        allow_any_instance_of(Workout).to receive(:update).and_return(false)
        patch :update, params: { id: workout.id, workout: { calories: new_calories } }
      end

      it "renders the edit workout page" do
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys a workout" do
      delete :destroy, params: { id: workout.id }

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(workouts_path)
      expect(flash).not_to be_empty
    end
  end

end
