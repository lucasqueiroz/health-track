require 'rails_helper'

RSpec.describe DashboardHelper, type: :helper do

  before do
    allow_any_instance_of(SessionsHelper).to receive(:current_user).and_return(user)
  end

  let(:height) { create(:height) }
  let(:weight) { create(:weight) }
  let(:user) { build(:user) }

  describe ".last_height_value" do
    context "when there is a last height" do
      before do
        allow_any_instance_of(DashboardHelper).to receive(:last_height).and_return(height)
      end

      it "returns correct height value" do
        expect(helper.last_height_value).to eq(height.measurement)
      end
    end

    context "when there is no height" do
      it "returns correct information" do
        expect(helper.last_height_value).to eq("No last height")
      end
    end
  end

  describe ".last_height_date" do
    context "when there is a last height" do
      before do
        allow_any_instance_of(DashboardHelper).to receive(:last_height).and_return(height)
      end

      it "returns correct height date" do
        expect(helper.last_height_date).to eq(height.measured_at)
      end
    end

    context "when there is no height" do
      it "returns correct information" do
        expect(helper.last_height_date).to eq("No last height")
      end
    end
  end

  describe ".last_weight_value" do
    context "when there is a last weight" do
      before do
        allow_any_instance_of(DashboardHelper).to receive(:last_weight).and_return(weight)
      end

      it "returns correct weight value" do
        expect(helper.last_weight_value).to eq(weight.measurement)
      end
    end

    context "when there is no weight" do
      it "returns correct information" do
        expect(helper.last_weight_value).to eq("No last weight")
      end
    end
  end

  describe ".last_weight_date" do
    context "when there is a last weight" do
      before do
        allow_any_instance_of(DashboardHelper).to receive(:last_weight).and_return(weight)
      end

      it "returns correct weight date" do
        expect(helper.last_weight_date).to eq(weight.measured_at)
      end
    end

    context "when there is no weight" do
      it "returns correct information" do
        expect(helper.last_weight_date).to eq("No last weight")
      end
    end
  end

end
