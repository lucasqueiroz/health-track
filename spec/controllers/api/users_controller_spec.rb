require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do
  include ApiSpecHelper

  describe "GET #index" do
    before do
      create(:user)
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

end
