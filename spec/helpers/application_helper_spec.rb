require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do

  describe ".format_date" do
    let(:date) { Date.new(2018, 01, 01) }
    it "returns correct formatted date" do
      expect(helper.format_date(date)).to eq("01/01/2018")
    end
  end

end
