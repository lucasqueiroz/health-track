require 'rails_helper'

RSpec.describe SessionsHelper, type: :helper do

  let(:user) { create(:user) }

  describe ".log_in" do
    context "when logging in a valid user" do
      before do
        log_in(user)
      end

      subject { session[:user_id] }
      it { is_expected.not_to be_nil }
    end
  end

  describe ".current_user" do
    context "when user is logged in" do
      before do
        log_in(user)
      end

      subject { current_user }
      it { is_expected.to eq(user) }
    end

    context "when no user is logged in" do
      subject { current_user }
      it { is_expected.to be_nil }
    end
  end

  describe ".logged_in?" do
    context "when user is logged in" do
      before do
        log_in(user)
      end

      subject { logged_in? }
      it { is_expected.to be true }
    end

    context "when no user is logged in" do
      subject { logged_in? }
      it { is_expected.to be false }
    end
  end

  describe ".log_out" do
    before do
      log_in(user)
      log_out
    end

    it "logs user out" do
      expect(session).not_to have_key(:user_id)
      expect(current_user).to be_nil
    end
  end

end