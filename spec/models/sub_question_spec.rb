require 'rails_helper'

RSpec.describe SubQuestion, type: :model do

  it "has a valid factory" do
    expect(FactoryGirl.create(:sub_question)).to be_valid
  end

  it "is valid with all required attributes" do
    expect(FactoryGirl.build(:sub_question)).to be_valid
  end

  it "is invalid without a description" do
    expect(FactoryGirl.build(:sub_question, description: nil)).to_not be_valid
  end

  it "is invalid without a monitoring_information" do
    expect(FactoryGirl.build(:sub_question, monitoring_information: nil)).to_not be_valid
  end

  it "is invalid without performance_indicators" do
    expect(FactoryGirl.build(:sub_question, performance_indicators: [])).to_not be_valid
  end
end
