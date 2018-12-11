require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
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

end
