require 'rails_helper'

RSpec.describe Framework, type: :model do

  it "has a valid factory" do
    expect(FactoryGirl.create(:framework)).to be_valid
  end

  it "is valid with all required attributes" do
    expect(FactoryGirl.build(:framework)).to be_valid
  end

  it "is invalid without a name" do
    expect(FactoryGirl.build(:framework, name: nil)).to_not be_valid
  end
end