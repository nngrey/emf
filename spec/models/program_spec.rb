require 'rails_helper'

RSpec.describe Program, type: :model do

  it "has a valid factory" do
    expect(FactoryGirl.create(:program)).to be_valid
  end

  it "is valid with all required attributes" do
    expect(FactoryGirl.build(:program)).to be_valid
  end

  it "is not valid if the end_date is before the start_date" do
    program = FactoryGirl.build(:program, start_date: Date.today, end_date: Date.today - 1)
  end

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name) }
end