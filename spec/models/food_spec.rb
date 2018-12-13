require 'rails_helper'

RSpec.describe Food, type: :model do
  let(:food) { create(:food) }

  context "when attributes are valid" do
    subject { food }
    it { is_expected.to be_valid }
  end

  context "when name is emtpy" do
    before do
      food.name = ''
    end

    subject { food }
    it { is_expected.not_to be_valid }
  end

  context "when name is longer than 50 characters" do
    before do
      food.name = 'a' * 51
    end

    subject { food }
    it { is_expected.not_to be_valid }
  end

  context "when calories is empty" do
    before do
      food.calories = ''
    end

    subject { food }
    it { is_expected.not_to be_valid }
  end

  context "when calories is not a number" do
    before do
      food.calories = 'a'
    end

    subject { food }
    it { is_expected.not_to be_valid }
  end

  context "when calories is a float" do
    before do
      food.calories = Faker::Number.decimal(1, 1)
    end

    subject { food }
    it { is_expected.not_to be_valid }
  end

  context "when calories are under 0" do
    before do
      food.calories = Faker::Number.negative
    end

    subject { food }
    it { is_expected.not_to be_valid }
  end

  context "when calories are over 10000" do
    before do
      food.calories = Faker::Number.number(6)
    end

    subject { food }
    it { is_expected.not_to be_valid }
  end

  context "when occurred at is empty" do
    before do
      food.calories = ''
    end

    subject { food }
    it { is_expected.not_to be_valid }
  end

  context "when occurred at is after today" do
    before do
      food.calories = Date.today + 1
    end

    subject { food }
    it { is_expected.not_to be_valid }
  end

  context "when occurred at is before 1900" do
    before do
      food.calories = Date.new(1899, 12, 31)
    end

    subject { food }
    it { is_expected.not_to be_valid }
  end
end
