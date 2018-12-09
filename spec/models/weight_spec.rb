require 'rails_helper'

RSpec.describe Weight, type: :model do
  let(:weight) { create(:weight) }

  context "when attributes are valid" do
    subject { weight }
    it { is_expected.to be_valid }
  end

  context "when measurement is emtpy" do
    before do
      weight.measurement = ''
    end

    subject { weight }
    it { is_expected.not_to be_valid }
  end

  context "when measurement is not a number" do
    before do
      weight.measurement = 'a'
    end

    subject { weight }
    it { is_expected.not_to be_valid }
  end

  context "when measurement is less than 20" do
    before do
      weight.measurement = 19
    end

    subject { weight }
    it { is_expected.not_to be_valid }
  end

  context "when measurement is greater than 500" do
    before do
      weight.measurement = 501
    end

    subject { weight }
    it { is_expected.not_to be_valid }
  end

  context "when measured at is empty" do
    before do
      weight.measured_at = ''
    end

    subject { weight }
    it { is_expected.not_to be_valid }
  end

  context "when measured at is after today" do
    before do
      weight.measured_at = Date.today + 1
    end

    subject { weight }
    it { is_expected.not_to be_valid }
  end

  context "when measured at is before 1900" do
    before do
      weight.measured_at = Date.new(1899, 12, 31)
    end

    subject { weight }
    it { is_expected.not_to be_valid }
  end
end
