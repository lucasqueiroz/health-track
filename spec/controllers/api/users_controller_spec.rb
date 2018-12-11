require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do
  include ApiSpecHelper

  before do
    controller.request.env['HTTP_AUTHORIZATION'] = basic_auth(user.email, user.password)
  end

  let!(:user) { create(:user) }
  let!(:different_user) { create(:different_user) }
  let!(:third_user) { create(:third_user) }

  describe "GET #index" do
    before do
      get :index
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "returns valid JSON body" do
      expect(json).not_to be_empty
      expect(json.size).to eq(3)
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

    context "when user is not the owner of the account" do
      before do
        controller.request.env['HTTP_AUTHORIZATION'] = basic_auth(third_user.email, third_user.password)
        get :show, params: { id: different_user.id }
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

    context "when user is not authorized" do
      before do
        controller.request.env['HTTP_AUTHORIZATION'] = basic_auth('email', 'password')
        get :show, params: { id: user.id }
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

  describe "PATCH #update" do
    context "when updated information is valid" do
      before do
        patch :update, params: { id: user.id, user: { name: 'Lucas Queiroz', email: 'new_email@gmail.com', birthday: '26/02/1997' } }
      end

      it "returns http success" do
        expect(response).to have_http_status(:ok)
      end

      it "returns valid JSON body" do
        expect(json).not_to be_empty
        expect(json['email']).to eq('new_email@gmail.com')
        expect(json['errors']).to be_nil
      end
    end

    context "when updated information is invalid" do
      before do
        patch :update, params: { id: user.id, user: { name: 'Lucas Queiroz', email: 'new_email@wrong', birthday: '26/02/1997' } }
      end

      it "returns http success" do
        expect(response).to have_http_status(:ok)
      end

      it "returns valid JSON body" do
        expect(json).not_to be_empty
        expect(json['errors']).not_to be_empty
      end
    end

    context "when user is not the owner of the account" do
      before do
        controller.request.env['HTTP_AUTHORIZATION'] = basic_auth(third_user.email, third_user.password)
        patch :update, params: { id: different_user.id, user: { name: 'Lucas Queiroz', email: 'new_email@gmail.com', birthday: '26/02/1997' } }
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

    context "when user is not authorized" do
      before do
        controller.request.env['HTTP_AUTHORIZATION'] = basic_auth('email', 'password')
        patch :update, params: { id: user.id, user: { name: 'Lucas Queiroz', email: 'new_email@gmail.com', birthday: '26/02/1997' } }
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

  describe "DELETE #destroy" do
    before do
      delete :destroy, params: { id: user.id }
    end

    it "returns http no content" do
      expect(response).to have_http_status(:no_content)
    end

    context "when user is not the owner of the account" do
      before do
        controller.request.env['HTTP_AUTHORIZATION'] = basic_auth(third_user.email, third_user.password)
        delete :destroy, params: { id: different_user.id }
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

    context "when user is not authorized" do
      before do
        controller.request.env['HTTP_AUTHORIZATION'] = basic_auth('email', 'password')
        delete :destroy, params: { id: user.id }
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
