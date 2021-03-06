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
      expect(json.size).to eq(User.all.size)
      expect(json.first['password_digest']).to be_nil
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
      expect(json['password_digest']).to be_nil
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
    let(:new_name) { Faker::Name.name }
    let(:new_email) { Faker::Internet.email }
    let(:new_birthday) { Faker::Date.birthday(18, 65) }
    let(:new_password) { Faker::Name.first_name.downcase }
    let(:new_user) { { user: { name: new_name, email: new_email, birthday: new_birthday, password: new_password } } }

    context "when user is valid" do
      before do
        post :create, params: new_user
      end

      it "returns http success" do
        expect(response).to have_http_status(:ok)
      end

      it "returns valid JSON body" do
        expect(json).not_to be_empty
        expect(json['email']).to eq(new_email)
      end
    end

    context "when user is invalid" do
      let(:new_email) { 'invalid@email' }

      before do
        post :create, params: new_user
      end

      it "returns http success" do
        expect(response).to have_http_status(:ok)
      end

      it "returns valid JSON body" do
        expect(json).not_to be_empty
        expect(json['errors']).not_to be_empty
      end
    end

    context "when saving fails" do
      before do
        allow_any_instance_of(User).to receive(:save).and_return(false)
        post :create, params: new_user
      end

      it "returns error JSON" do
        expect(json).not_to be_empty
        expect(json).to have_key('errors')
      end
    end
  end

  describe "PATCH #update" do
    let(:new_email) { Faker::Internet.email }

    context "when updated information is valid" do
      before do
        patch :update, params: { id: user.id, user: { email: new_email } }
      end

      it "returns http success" do
        expect(response).to have_http_status(:ok)
      end

      it "returns valid JSON body" do
        expect(json).not_to be_empty
        expect(json['email']).to eq(new_email)
        expect(json['errors']).to be_nil
      end
    end

    context "when updated information is invalid" do
      let(:new_email) { 'invalid@email' }

      before do
        patch :update, params: { id: user.id, user: { email: new_email } }
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
        patch :update, params: { id: different_user.id, user: { email: new_email } }
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
        patch :update, params: { id: user.id, user: { email: new_email } }
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
