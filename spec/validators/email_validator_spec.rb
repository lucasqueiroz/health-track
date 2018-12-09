require 'rails_helper'

class EmailValidatable
  include ActiveModel::Validations
  validates :email, email: true
  attr_accessor :email
end

RSpec.describe EmailValidator, type: :validator do
  subject { EmailValidatable.new }

  context "with valid email" do
    before do
      subject.email = 'lucascqueiroz97@gmail.com'
    end

    it { is_expected.to be_valid }
  end

  context "with valid brazilian email" do
    before do
      subject.email = 'lucascqueiroz97@gmail.com.br'
    end

    it { is_expected.to be_valid }
  end

  context "with invalid email" do
    before do
      subject.email = 'lucascqueiroz97@@@gmail.com'
    end

    it { is_expected.not_to be_valid }
  end
end