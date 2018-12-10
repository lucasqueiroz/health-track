require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do
  include ApiSpecHelper

  let!(:user) { create(:user) }

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
    end
  end

  describe "GET #show" do
    before do
      get :show, params: { id: user.id }
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "returns valid JSON body" do
      expect(json).not_to be_empty
      expect(json['id']).to eq(user.id)
    end
  end

  describe "POST #create" do
    context "when user is valid" do
      before do
        post :create, params: { user: { name: 'Lucas Queiroz', email: 'lucascqueiroz97@gmail.com.br', birthday: '26/02/1997', password: 'password' } }
      end

      it "returns http success" do
        expect(response).to have_http_status(:ok)
      end

      it "returns valid JSON body" do
        expect(json).not_to be_empty
        expect(json['email']).to eq('lucascqueiroz97@gmail.com.br')
      end
    end

    context "when user is invalid" do
      before do
        post :create, params: { user: { name: 'Lucas Queiroz', email: 'invalid@email', birthday: '26/02/1997', password: 'password' } }
      end

      it "returns http success" do
        expect(response).to have_http_status(:ok)
      end

      it "returns valid JSON body" do
        expect(json).not_to be_empty
        expect(json['errors']).not_to be_empty
      end
    end
  end

end
