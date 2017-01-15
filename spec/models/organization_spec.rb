require 'rails_helper'

RSpec.describe Organization, type: :model do

  it "has a valid factory" do
    expect(FactoryGirl.create(:organization)).to be_valid
  end

  it "is valid with all required attributes" do
    expect(FactoryGirl.build(:organization)).to be_valid
  end

  it { is_expected.to validate_presence_of(:name) }
end