require 'rails_helper'

RSpec.describe Api::FoodsController, type: :controller do
  include ApiSpecHelper

  before do
    controller.request.env['HTTP_AUTHORIZATION'] = basic_auth(user.email, user.password)
  end

  let!(:food) { create(:food) }
  let!(:different_food) { create(:different_food) }
  let(:user) { build(:user) }
  let(:different_user) { build(:different_user) }
  let(:third_user) { create(:third_user) }

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
      expect(json[0]['user_id']).to eq(food.user.id)
    end
  end
end
