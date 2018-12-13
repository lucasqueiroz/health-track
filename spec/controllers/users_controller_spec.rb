require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  let(:user) { create(:user) }

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    context "when user is logged in" do
      before do
        allow_any_instance_of(SessionsHelper).to receive(:logged_in?).and_return(true)
        get :new
      end

      it "redirects the user to the dashboard" do
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "GET #edit" do
    context "when user is logged in" do
      before do
        allow_any_instance_of(SessionsHelper).to receive(:logged_in?).and_return(true)
        get :edit, params: { id: user.id }
      end

      it "returns http success" do
        get :edit, params: { id: user.id }
        expect(response).to have_http_status(:success)
      end
    end

    context "when user is not logged in" do
      before do
        allow_any_instance_of(SessionsHelper).to receive(:logged_in?).and_return(false)
        get :edit, params: { id: user.id }
      end

      it "redirects the user to the dashboard" do
        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe "GET #show" do
    context "when user is logged in" do
      before do
        allow_any_instance_of(SessionsHelper).to receive(:logged_in?).and_return(true)
        get :show, params: { id: user.id }
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
    end

    context "when user is not logged in" do
      before do
        allow_any_instance_of(SessionsHelper).to receive(:logged_in?).and_return(false)
        get :show, params: { id: user.id }
      end

      it "returns http success" do
        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe "POST #create" do
    it "creates a user when information is valid" do
      post :create, params:
        { user: { name: 'Lucas Queiroz', email: 'lucascqueiroz97@gmail.com', birthday: '26/02/1997', password: 'pass' } }

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(login_path)
      expect(User.last.name).to eq('Lucas Queiroz')
    end

    it "fails when information is invalid" do
      post :create, params:
        { user: { name: 'Lucas Queiroz', email: 'lucascqueiroz97@gmail.com', birthday: '26/02/1997' } }

      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:new)
    end
  end

  describe "PATCH #update" do
    context "when user is logged in" do
      before do
        allow_any_instance_of(SessionsHelper).to receive(:logged_in?).and_return(true)
        allow_any_instance_of(SessionsHelper).to receive(:current_user).and_return(user)
      end

      it "updates a user when information is valid" do
        patch :update, params: { id: user.id, user: { name: 'Lucas C Queiroz' } }

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(user)
        expect(User.last.name).to eq('Lucas C Queiroz')
      end
    end

    context "when user is not logged in" do
      before do
        allow_any_instance_of(SessionsHelper).to receive(:logged_in?).and_return(false)
        patch :update, params: { id: user.id, user: { name: 'Lucas C Queiroz' } }
      end

      it "redirects user" do
        expect(response).to redirect_to(login_path)
      end
    end
  end

end
