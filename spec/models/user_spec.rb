require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  context "when attributes are valid" do
    subject { user }
    it { is_expected.to be_valid }
  end

  context "when name is empty" do
    before do
      user.name = ''
    end

    subject { user }
    it { is_expected.not_to be_valid }
  end

  context "when name is longer than 100 characters" do
    before do
      user.name = 'a' * 101
    end

    subject { user }
    it { is_expected.not_to be_valid }
  end

  context "when email is empty" do
    before do
      user.email = ''
    end

    subject { user }
    it { is_expected.not_to be_valid }
  end

  context "when email is longer than 200 characters" do
    before do
      user.email = 'a' * 201
    end

    subject { user }
    it { is_expected.not_to be_valid }
  end

  context "when email is invalid" do
    before do
      user.email = 'aaa'
    end

    subject { user }
    it { is_expected.not_to be_valid }
  end

  context "when birthday is empty" do
    before do
      user.birthday = ''
    end

    subject { user }
    it { is_expected.not_to be_valid }
  end
end
