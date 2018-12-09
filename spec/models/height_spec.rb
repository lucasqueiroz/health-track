require 'rails_helper'

RSpec.describe Height, type: :model do
  let(:height) { create(:height) }

  context "when attributes are valid" do
    subject { height }
    it { is_expected.to be_valid }
  end

  context "when measurement is emtpy" do
    before do
      height.measurement = ''
    end

    subject { height }
    it { is_expected.not_to be_valid }
  end

  context "when measurement is not a number" do
    before do
      height.measurement = 'a'
    end

    subject { height }
    it { is_expected.not_to be_valid }
  end

  context "when measurement is less than 0" do
    before do
      height.measurement = -0.1
    end

    subject { height }
    it { is_expected.not_to be_valid }
  end

  context "when measurement is greater than 3" do
    before do
      height.measurement = -3.1
    end

    subject { height }
    it { is_expected.not_to be_valid }
  end

  context "when measured at is empty" do
    before do
      height.measured_at = ''
    end

    subject { height }
    it { is_expected.not_to be_valid }
  end
end
