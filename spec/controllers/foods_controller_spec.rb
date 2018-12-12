require 'rails_helper'

RSpec.describe FoodsController, type: :controller do

  before do
    allow_any_instance_of(FoodsController).to receive(:current_user).and_return(user)
  end

  let(:food) { create(:food) }
  let(:user) { food.user }

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
    it "creates a food when information is valid" do
      post :create, params: { food: { name: 'Poutine', calories: 740, occurred_at: '22/10/2018' } }

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(foods_path)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, params: { id: food.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #update" do
    it "edits a food when information is valid" do
      patch :update, params: { id: food.id, food: { name: 'Poutine', calories: 745, occurred_at: '22/10/2018' } }

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(foods_path)
      expect(Food.last.calories).to eq(745)
    end
  end

  describe "DELETE #destroy" do
    it "destroys a food" do
      delete :destroy, params: { id: food.id }

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(foods_path)
      expect(flash).not_to be_empty
    end
  end

end
