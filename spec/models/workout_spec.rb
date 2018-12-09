require 'rails_helper'

RSpec.describe Workout, type: :model do
  let(:workout) { create(:workout) }

  context "when attributes are valid" do
    subject { workout }
    it { is_expected.to be_valid }
  end

  context "when name is emtpy" do
    before do
      workout.name = ''
    end

    subject { workout }
    it { is_expected.not_to be_valid }
  end

  context "when name is longer than 50 characters" do
    before do
      workout.name = 'a' * 51
    end

    subject { workout }
    it { is_expected.not_to be_valid }
  end

  context "when calories is empty" do
    before do
      workout.calories = ''
    end

    subject { workout }
    it { is_expected.not_to be_valid }
  end

  context "when calories is not a number" do
    before do
      workout.calories = 'a'
    end

    subject { workout }
    it { is_expected.not_to be_valid }
  end

  context "when calories is a float" do
    before do
      workout.calories = 1.50
    end

    subject { workout }
    it { is_expected.not_to be_valid }
  end

  context "when calories are under 0" do
    before do
      workout.calories = -1
    end

    subject { workout }
    it { is_expected.not_to be_valid }
  end

  context "when calories are over 10000" do
    before do
      workout.calories = 10_001
    end

    subject { workout }
    it { is_expected.not_to be_valid }
  end

  context "when occurred at is empty" do
    before do
      workout.calories = ''
    end

    subject { workout }
    it { is_expected.not_to be_valid }
  end

  context "when occurred at is after today" do
    before do
      workout.calories = Date.today + 1
    end

    subject { workout }
    it { is_expected.not_to be_valid }
  end

  context "when occurred at is before 1900" do
    before do
      workout.calories = Date.new(1899, 12, 31)
    end

    subject { workout }
    it { is_expected.not_to be_valid }
  end

end
