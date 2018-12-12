require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  let(:user) { create(:user) }

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    context "when valid login information is sent" do
      it "should log in user" do
        post :create, params: { session: { email: user.email, password: user.password } }
        expect(response).to redirect_to(root_path)
      end
    end

    context "when invalid login information is sent" do
      it "should display error message" do
        post :create, params: { session: { email: '', password: '' } }
        expect(response).to render_template(:new)
        expect(flash).not_to be_empty
      end
    end
  end

  describe "DELETE #destroy" do
    context "when user is logged in" do
      before do
        allow_any_instance_of(SessionsHelper).to receive(:logged_in?).and_return(true)
      end

      it "logs user out" do
        delete :destroy
        expect(flash).to be_empty
        expect(response).to redirect_to(root_path)
      end
    end

    context "when user is not logged in" do
      before do
        allow_any_instance_of(SessionsHelper).to receive(:logged_in?).and_return(false)
      end

      it "gives proper error" do
        delete :destroy
        expect(flash).not_to be_empty
        expect(response).to redirect_to(root_path)
      end
    end
  end

end
