require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    context "when invalid login information is sent" do
      it "should display error message" do
        post :create, params: { session: { email: '', password: '' } }
        expect(response).to render_template(:new)
        expect(flash).not_to be_empty
      end
    end
  end

end
