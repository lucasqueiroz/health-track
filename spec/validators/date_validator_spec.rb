require 'rails_helper'

class DateValidatable
  include ActiveModel::Validations
  validates :date, date: true
  attr_accessor :date
end

class DateValidatableWithOptions
  include ActiveModel::Validations
  validates :date, date: { after: Date.new(2000, 1, 1),
                            before: Date.new(2001, 1, 1) }
  attr_accessor :date
end

RSpec.describe DateValidator, type: :validator do
  describe "validate date" do
    context "when model has no options" do
      subject { DateValidatable.new }

      context "with valid date" do
        before do
          subject.date = Date.today - 1
        end

        it { is_expected.to be_valid }
      end

      context "with invalid date" do
        before do
          subject.date = Date.today + 1
        end

        it { is_expected.not_to be_valid }
      end
    end

    context "when model has options" do
      subject { DateValidatableWithOptions.new }

      context "with valid date" do
        before do
          subject.date = Date.new(2000, 5, 1)
        end

        it { is_expected.to be_valid }
      end

      context "with invalid date" do
        before do
          subject.date = Date.new(2001, 1, 2)
        end

        it { is_expected.not_to be_valid }
      end
    end
  end
end