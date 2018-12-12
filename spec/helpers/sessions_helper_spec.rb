require 'rails_helper'

RSpec.describe SessionsHelper, type: :helper do

  let(:user) { create(:user) }

  describe ".log_in" do
    context "when logging in a valid user" do
      before do
        helper.log_in(user)
      end

      it "has user id in session" do
        expect(session[:user_id]).not_to be_nil
      end
    end
  end

  describe ".log_out" do
    before do
      helper.log_in(user)
      helper.log_out
    end

    it "logs user out" do
      expect(session).not_to have_key(:user_id)
      expect(helper.current_user).to be_nil
    end
  end

  describe ".current_user" do
    context "when user is logged in" do
      before do
        session[:user_id] = user.id
      end

      it "returns correct user" do
        expect(helper.current_user).to eq(user)
      end
    end

    context "when user is not logged in" do
      it "returns nil user" do
        expect(helper.current_user).to be_nil
      end
    end
  end

  describe ".logged_in?" do
    context "when user is logged in" do
      before do
        allow_any_instance_of(SessionsHelper).to receive(:current_user).and_return(user)
      end

      it "returns true" do
        expect(helper.logged_in?).to be true
      end
    end

    context "when user is not logged in" do
      before do
        allow_any_instance_of(SessionsHelper).to receive(:current_user).and_return(nil)
      end

      it "returns true" do
        expect(helper.logged_in?).to be false
      end
    end
  end

end
